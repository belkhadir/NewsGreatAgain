//
//  App Purchases.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/4/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import Foundation

let productIdentifiers = "com.newsgreatagain.removeads"
let subscriptionIdentifiers = "com.newsgreatagain.newsgreatagain.allaccess"

var isFreeFromAds: Bool {
    return UserDefaults.standard.bool(forKey: UserDefaultKey.purchased.rawValue)
}
