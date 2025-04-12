//
//  ContentView.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 4/10/25.
//

import SwiftUI
import CleverTapSDK

struct ContentView: View {
    @State private var loggedInUser: String? = nil
    var body: some View {
        VStack {
            Text("Logged in User: \(loggedInUser ?? "No user logged in")")
            Spacer()
            Button("Log in Max Margolis") {
                print("Max Margolis has been logged in")
                loggedInUser = "Max Margolis"
            }
            Spacer()
        }
        .padding()
    }
}

private extension ContentView {
    func logInMaxMargolis() {
        
    }
}

#Preview {
    ContentView()
}
