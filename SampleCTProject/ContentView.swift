//
//  ContentView.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 4/10/25.
//

import SwiftUI
import CleverTapSDK

private enum NavigationDestinations {
    case appInbox
    case eventCreator
}

struct ContentView: View {
    @State private var loggedInUser: String? = nil
    @State private var viewDidLoad = false
    var body: some View {
        NavigationStack {
            VStack(spacing:100) {
                Text("Logged in User: \(loggedInUser ?? "No user logged in")")
                Button("Log in Max Margolis") {
                    print("MaxLog: Max Margolis has been logged in")
                    loggedInUser = "Max Margolis"
                    logInMaxMargolis()
                }
                NavigationLink("Go To App Inbox", value: NavigationDestinations.appInbox)

                NavigationLink("Go To Event Creator", value: NavigationDestinations.eventCreator)

            }
            .onAppear() {
                if viewDidLoad == false {
                    viewDidLoad = true
                    initializeAppInbox()
                }
            }
            .onOpenURL { incomingURL in
                print("MaxLog: App was opened via URL: \(incomingURL)")
            }
            .navigationDestination(for: NavigationDestinations.self) { destination in
                switch destination {
                case .eventCreator:
                    EventCreator()
                case .appInbox:
                    CTAppInboxRepresentable()
                        .navigationTitle("My App Inbox")
                        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                        .toolbarBackground(.purple, for: .navigationBar)
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
                print("MaxLog: Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
         }))
    }
    
    func handleIncomingURL(_ url: URL) {
        guard url.scheme == "ctsample1" else {
            return
        }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("MaxLog: Deep link invalid URL")
            return
        }
        guard let action = components.host, action == "open-screen" else {
            print("MaxLog: Deep link unknown URL")
            return
        }
        guard let screenName = components.queryItems?.first(where: { $0.name == "screen" })?.value else {
            print("MaxLog: Deep link screen name not found")
            return
        }
        if screenName == "main" { return }
        
    }
}

#Preview {
    ContentView()
}
