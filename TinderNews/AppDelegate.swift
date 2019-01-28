//
//  AppDelegate.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import StoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let date = UserDefaults.standard.object(forKey: UserDefaultKey.day.rawValue) as? Date {
            if Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedAscending {
                TrackPageHelper.setToZero()
            }
        }
        
        UserDefaults.standard.set(Date(), forKey: UserDefaultKey.day.rawValue)
        
        FirebaseApp.configure()
        
        GADMobileAds.configure(withApplicationID: ADMOB_APP_ID)
        
        StoreReviewHelper.incrementAppOpenedCount()
        SKPaymentQueue.default().add(self)
        SubscriptionService.shared.loadSubscriptionOptions()

        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let navigationBarApearace = UINavigationBar.appearance()
        navigationBarApearace.tintColor = .white
        navigationBarApearace.barTintColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        
        window?.rootViewController = isLogged ? MainViewController() : UINavigationController(rootViewController: JoinViewController())
        
        window?.makeKeyAndVisible()
        
        
        return true
    }
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            debugPrint("The url is \(incomingURL)")
            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) {[weak self] (dynamicLink, error) in
                guard let weakSelf = self else {
                    return
                }
                guard error == nil else {
                    debugPrint("Found error \(error!.localizedDescription)")
                    return
                }
                if let dynamicLink = dynamicLink {
                    weakSelf.handleIncomingDynamicLink(dynamicLink)
                }
            }
            return linkHandled
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        //        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
        //            return true
        //        }
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromUniversalLink: url) {
            handleIncomingDynamicLink(dynamicLink)
            return true
        }
            
        else {
//            return SDKApplicationDelegate.shared.application(app, open: url, options: options)
            //                SDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        }
        
        return false
    }
    
    
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else {
            debugPrint("There's no such dynamic links")
            return
        }
        
        debugPrint("Upcoming dynamic link \(url.absoluteString)")
        guard let componets = URLComponents(url: url, resolvingAgainstBaseURL: true), let query = componets.queryItems else {
            debugPrint("No compenets")
            return
        }
        
        let invitedBy = query.filter({(item) in item.name == "invitedby"}).first?.value
        
        if invitedBy != nil {
            UserDefaults.standard.set(invitedBy!, forKey: UserDefaultKey.invitedBy.rawValue)
        }
        
//        for queryElement in query {
//            debugPrint("Name : \(queryElement.name) , The value : \(queryElement.value)")
//        }
    }
    

    
    func handleDynamicLink(_ dynamicLink: DynamicLink?) -> Bool {
        guard let dynamicLink = dynamicLink else { return false }
        guard let deepLink = dynamicLink.url else { return false }
        let queryItems = URLComponents(url: deepLink, resolvingAgainstBaseURL: true)?.queryItems
        let invitedBy = queryItems?.filter({(item) in item.name == "invitedby"}).first?.value
        
        // If the user isn't signed in and the app was opened via an invitation
        // link, sign in the user anonymously and record the referrer UID in the
        // user's RTDB record.
        
        if invitedBy != nil {
            UserDefaults.standard.set(invitedBy!, forKey: UserDefaultKey.invitedBy.rawValue)
        }
        
        return true
    }
    
    

    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken
    }

    
    var isLogged: Bool {
        return  UserDefaults.standard.bool(forKey: UserDefaultKey.isLogged.rawValue)
    }
    

    
}

// MARK: - SKPaymentTransactionObserver

extension AppDelegate: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                handlePurchasingState(for: transaction, in: queue)
            case .purchased:
                handlePurchasedState(for: transaction, in: queue)
            case .restored:
                handleRestoredState(for: transaction, in: queue)
            case .failed:
                handleFailedState(for: transaction, in: queue)
            case .deferred:
                handleDeferredState(for: transaction, in: queue)
            }
        }
    }
    
    func handlePurchasingState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("User is attempting to purchase product id: \(transaction.payment.productIdentifier)")
    }
    
    func handlePurchasedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("User purchased product id: \(transaction.payment.productIdentifier)")
        
        queue.finishTransaction(transaction)
        SubscriptionService.shared.uploadReceipt { (success) in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: SubscriptionService.purchaseSuccessfulNotification, object: nil)
            }
        }
    }
    
    func handleRestoredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase restored for product id: \(transaction.payment.productIdentifier)")
        queue.finishTransaction(transaction)
        SubscriptionService.shared.uploadReceipt { (success) in
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: SubscriptionService.restoreSuccessfulNotification, object: nil)
            }
        }
    }
    
    func handleFailedState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase failed for product id: \(transaction.payment.productIdentifier)")
    }
    
    func handleDeferredState(for transaction: SKPaymentTransaction, in queue: SKPaymentQueue) {
        print("Purchase deferred for product id: \(transaction.payment.productIdentifier)")
    }
}
