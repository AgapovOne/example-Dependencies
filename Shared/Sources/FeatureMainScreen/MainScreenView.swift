import SwiftUI

public struct MainScreenView: View {
    @State private var token = "loading"

    public init() {}

    public var body: some View {
        VStack {
            Text("Api token value")
            Text(token)
            Text("---")
            Text("Main actor calculated size")
            Text(Dependencies.size().debugDescription)
            Text("---")
            Button {
                Task {
                    try await Dependencies.track("btn_tap")
                }
            } label: {
                Text("Track button tap")
            }
            Text("---")
            Button {
                Dependencies.external.route(.settings)
            } label: {
                Text("Open settings")
            }
            .buttonStyle(BorderedButtonStyle())

        }
        .task {
            token = Dependencies.apiToken()
        }
    }
}

#Preview {
    SetupMainScreenDependencies(.init(route: { print($0) }))
    return MainScreenView()
}
