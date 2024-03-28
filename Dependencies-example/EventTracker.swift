//
//  EventTracker.swift
//  Dependencies-example
//
//  Created by Alex Agapov on 28.03.2024.
//

import Foundation

enum EventTracker {
    static func track(_ event: String) async throws {
        print("event \(event) is being processed with token \(Dependencies.apiToken())")
        try await Task.sleep(for: .seconds(1))
        print("tracked \(event)")
    }
}
