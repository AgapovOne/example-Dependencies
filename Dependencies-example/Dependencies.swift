//
//  Dependencies.swift
//  Dependencies-example
//
//  Created by Alex Agapov on 28.03.2024.
//

import Foundation
import ConcurrencyExtras
import UIKit

struct ModuleDependencies: Sendable {
    var apiToken: @Sendable () -> String
    var size: @Sendable @MainActor () -> CGSize
    var track: @Sendable (String) async throws -> Void
}

let Dependencies = LockIsolated(
    dependencies(
        live: ModuleDependencies.live,
        preview: .preview,
        failing: .failing
    )
)

extension ModuleDependencies {
    static var live: Self {
        .init(
            apiToken: { "REAL" },
            size: { UIScreen.main.bounds.size },
            track: { try await EventTracker.track($0) }
        )
    }

    static var preview: Self {
        .init(
            apiToken: { "REAL" },
            size: { .init(width: 999, height: 999) },
            track: { print("debug \($0)") }
        )
    }

    static var failing: Self {
        .init(
            apiToken: { unimplemented("apiToken") },
            size: { unimplemented("size") },
            track: { _ in unimplemented("track") }
        )
    }
}

// MARK: - Helper defined in share module

import XCTestDynamicOverlay

var isPreview: () -> Bool {
    { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }
}

public func dependencies<Dependencies>(
    live: @autoclosure () -> Dependencies,
    preview: @autoclosure () -> Dependencies?,
    failing: @autoclosure () -> Dependencies?
) -> Dependencies {
    if _XCTIsTesting {
        if let failingValue = failing() {
            return failingValue
        }
    }

    if isPreview() {
        if let previewValue = preview() {
            return previewValue
        }
    }

    return live()
}

