//
//  StoreKit.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/17/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//


import Foundation
import StoreKit

struct StoreReviewHelper {
    static func incrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:
        var appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultKey.appOpenAccount.rawValue)
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: UserDefaultKey.appOpenAccount.rawValue)
    }
    static func checkAndAskForReview() { // call this whenever appropriate
        // this will not be shown everytime. Apple has some internal logic on how to show this.
        let appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultKey.appOpenAccount.rawValue)
        
        switch appOpenCount {
        case 5,10:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break;
        }
        
    }
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
            // Try any other 3rd party or manual method here.
        }
    }
}
