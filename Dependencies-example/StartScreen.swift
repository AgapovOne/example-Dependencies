import SwiftUI
import FeatureSettings
import FeatureMainScreen

@MainActor
struct StartScreen: View {

    enum Tab: Int, Hashable {
        case main
        case settings
    }

    @State private var selectedTab: Tab = .main

    var body: some View {
        TabView(selection: $selectedTab) {
            MainScreenView()
                .tabItem { Label("Main", systemImage: "list.clipboard") }
                .tag(Tab.main)

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
                .tag(Tab.settings)
        }
        .task {
            // Or AppDelegate? SceneDelgate?
            SetupMainScreenDependencies(.init(route: { route in
                Task { @MainActor in
                    select(route)
                }
            }))
        }

    }
    private func select(_ route: Route) {
        selectedTab = .settings
    }
}

#Preview {
    StartScreen()
}
