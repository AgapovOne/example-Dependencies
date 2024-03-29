import SwiftUI
import XCTestDynamicOverlay

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            if _XCTIsTesting {
                EmptyView()
            } else {
                StartScreen()
            }
        }
    }
}
