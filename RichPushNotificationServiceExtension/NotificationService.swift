//
//  NotificationService.swift
//  RichPushNotificationServiceExtension
//
//  Created by Max Balsam  Margolis on 4/17/25.
//

import CTNotificationService
import CleverTapSDK

class NotificationService: CTNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        registerPushImpression(with: request)
        super.didReceive(request, withContentHandler: contentHandler)
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    func registerPushImpression(with request: UNNotificationRequest) {
        guard let loggedInUserProperties = UserDefaults.group?.value(forKey: UserDefaultsKeys.loggedInUserPropertiesKey) as? [AnyHashable: Any] else {
            return
        }
        CleverTap.setCredentialsWithAccountID(Credentials.projectID, andToken: Credentials.projectToken)
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        CleverTap.sharedInstance()?.onUserLogin(loggedInUserProperties) // must call this first
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
    }
}
