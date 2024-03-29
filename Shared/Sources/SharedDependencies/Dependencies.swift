// The Swift Programming Language
// https://docs.swift.org/swift-book

import XCTestDynamicOverlay
import Foundation

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
