//
//  Dependencies_exampleApp.swift
//  Dependencies-example
//
//  Created by Alex Agapov on 28.03.2024.
//

import SwiftUI
import XCTestDynamicOverlay

@main
struct Dependencies_exampleApp: App {
    var body: some Scene {
        WindowGroup {
            if _XCTIsTesting {
                EmptyView()
            } else {
                ContentView()
            }
        }
    }
}
