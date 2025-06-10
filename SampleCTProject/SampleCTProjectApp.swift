//
//  SampleCTProjectApp.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 4/10/25.
//
import SwiftUI
#if DEBUG
import Atlantis
#endif

@main
struct SampleCTProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        #if DEBUG
        Atlantis.start()
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
