//
//  Dependencies.swift
//  Dependencies-example
//
//  Created by Alex Agapov on 28.03.2024.
//

import ConcurrencyExtras
import Foundation
import SharedDependencies
import UIKit
import XCTestDynamicOverlay

struct ModuleDependencies: Sendable {
    var apiToken: @Sendable () -> String
    var size: @Sendable @MainActor () -> CGSize
    var track: @Sendable (String) async throws -> Void

    var external: ModuleExternalDependencies!
}

public struct ModuleExternalDependencies: Sendable {
    let route: @Sendable (Route) -> Void

    public init(route: @escaping @Sendable (Route) -> Void) {
        self.route = route
    }
}

let Dependencies = LockIsolated(
    dependencies(
        live: ModuleDependencies.live,
        preview: .preview,
        failing: .failing
    )
)

public func SetupMainScreenDependencies(_ external: ModuleExternalDependencies) {
    Dependencies.withValue {
        $0.external = external
    }
}

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
            apiToken: { "PREVIEW" },
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
