//
//  AppDelegate.swift
//  TinderNews
//
//  Created by xxx on 11/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        GADMobileAds.configure(withApplicationID: ADMOB_APP_ID)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var controller: UIViewController?
        if isLogged {
            controller = MainViewController()
        }else {
            controller = JoinViewController()
        }
        window?.rootViewController = controller //home //news //NewsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
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
        
        for queryElement in query {
            debugPrint("Name : \(queryElement.name) , The value : \(queryElement.value)")
        }
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
    
    
    var isLogged: Bool {
        return  UserDefaults.standard.bool(forKey: UserDefaultKey.isLogged.rawValue)
    }
}



