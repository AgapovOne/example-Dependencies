//
//  ContentView.swift
//  Dependencies-example
//
//  Created by Alex Agapov on 28.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var token = "loading"

    var body: some View {
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

        }
        .task {
            token = Dependencies.apiToken()
        }
    }
}

#Preview {
    ContentView()
}
