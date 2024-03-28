//
//  Dependencies_exampleTests.swift
//  Dependencies-exampleTests
//
//  Created by Alex Agapov on 28.03.2024.
//

import XCTest
@testable import Dependencies_example
import ConcurrencyExtras

final class Dependencies_exampleTests: XCTestCase {

    func testTrackerWithDependenciesSetup() async throws {
// Without setup there is a crash:
//    Unimplemented: apiToken …
//
//      Defined at:
//        Dependencies_example/Dependencies.swift:45
        Dependencies.withValue {
            $0.apiToken = { "fake_token" }
        }
        try await EventTracker.track("fake_event")
    }
}
