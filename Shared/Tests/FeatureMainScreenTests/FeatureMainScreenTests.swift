import XCTest
@testable import FeatureMainScreen

final class FeatureMainScreenTests: XCTestCase {
    
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
