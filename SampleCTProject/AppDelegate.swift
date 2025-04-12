//
//  AppDelegate.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 4/11/25.
//

import UIKit
import CleverTapSDK

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupCleverTap()
        return true
    }
    
    private func setupCleverTap() {
        setCleverTapCredentials() // make sure to call this before autoIntegrate
        CleverTap.autoIntegrate()
        //By default, CleverTap logs are set to CleverTapLogLevel.info. During development, we recommend that you set the SDK to DEBUG mode, in order to log warnings or other important messages to the iOS logging system. This can be done by setting the debug level to CleverTapLogLevel.debug. If you want to disable CleverTap logs for production environment, you can set the debug level to CleverTapLogLevel.off.rawValue.
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
    }
    
    private func setCleverTapCredentials() {
        CleverTap.setCredentialsWithAccountID(Credentials.projectID, andToken: Credentials.projectToken)
    }
}
