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
        let news = NewsViewController()
        window?.rootViewController = news //NewsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        window?.makeKeyAndVisible()
        
        
        return true
    }
}



