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
        let maxMargolisProfile = ["Email": "max@clevertap.com",
                                     "Identity": "MaxMargolis"] as [String : AnyObject]
        CleverTap.setCredentialsWithAccountID(Credentials.projectID, andToken: Credentials.projectToken)
        CleverTap.sharedInstance()?.profilePush(maxMargolisProfile) // must call this first
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
    }
}
