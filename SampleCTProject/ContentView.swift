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
    @State private var viewDidLoad = false
    var body: some View {
        NavigationStack {
            VStack(spacing:100) {
                Text("Logged in User: \(loggedInUser ?? "No user logged in")")
                Button("Log in Max Margolis") {
                    print("Max Margolis has been logged in")
                    loggedInUser = "Max Margolis"
                    logInMaxMargolis()
                }
                NavigationLink("Go To App Inbox") {
                    CTAppInboxRepresentable()
                        .navigationTitle("My App Inbox")
                        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                        .toolbarBackground(.purple, for: .navigationBar)
                }
                NavigationLink("Go To Events Creator") {
                    Events()
                }
            }
            .onAppear() {
                if viewDidLoad == false {
                    viewDidLoad = true
                    initializeAppInbox()
                }
            }
        }
    }
}

private extension ContentView {
    func logInMaxMargolis() {
        let maxMargolisProperties = ["Email": "max@clevertap.com",
                                     "Name": "Max Margolis",
                                     "Identity": "MaxMargolis"] as [AnyHashable : Any]
        CleverTap.sharedInstance()?.onUserLogin(maxMargolisProperties)
    }
    
    func initializeAppInbox() {
        CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
                let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
                let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
                print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
         }))
    }
}

#Preview {
    ContentView()
}
