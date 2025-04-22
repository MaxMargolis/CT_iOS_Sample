//
//  AppDelegate.swift
//  SampleCTProject
//
//  Created by Max Balsam  Margolis on 4/11/25.
//

import UIKit
import CleverTapSDK
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupCleverTap()
        return true
    }
    
    private func setupCleverTap() {
        setCleverTapCredentials() // make sure to call this before autoIntegrate
        CleverTap.autoIntegrate()
        registerForPush()
        setNotificationCategories()
        setCleverTapLogLevelToDebugRaw()
    }
    
    // Should be called before autoIntegrate
    private func setCleverTapCredentials() {
        CleverTap.setCredentialsWithAccountID(Credentials.projectID, andToken: Credentials.projectToken)
    }
    
    /// Should be called after autoIntegrate
    private func registerForPush() {
        
        // Set delegate.
        UNUserNotificationCenter.current().delegate = self
        
        // Request Push Notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Request for Push Notification permission denied")
            }
        })
    }
    
    /// Sets debug log level to raw
    private func setCleverTapLogLevelToDebugRaw() {
        //By default, CleverTap logs are set to CleverTapLogLevel.info. During development, we recommend that you set the SDK to DEBUG mode, in order to log warnings or other important messages to the iOS logging system. This can be done by setting the debug level to CleverTapLogLevel.debug. If you want to disable CleverTap logs for production environment, you can set the debug level to CleverTapLogLevel.off.rawValue.
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
    }
    
    /// Sets categories for notification content extension
    private func setNotificationCategories() {
        let action1 = UNNotificationAction(identifier: "action_1", title: "Back", options: [])
        let action2 = UNNotificationAction(identifier: "action_2", title: "Next", options: [])
        let action3 = UNNotificationAction(identifier: "action_3", title: "View In App", options: [])
        let category = UNNotificationCategory(identifier: "CTNotification", actions: [action1, action2, action3], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
        }
        
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
            
        NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
        completionHandler()
    }
        
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
        NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
        completionHandler([.badge, .sound, .banner, .list])
    }
        
    func application(_ application: UIApplication,
                        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }
        
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        NSLog("pushNotificationTapped: customExtras: ", customExtras)
    }
    
}


