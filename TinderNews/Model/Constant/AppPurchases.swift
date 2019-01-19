//
//  App Purchases.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/4/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import Foundation



let monthlyAccess = "com.newsgreatagain.newsgreatagain.allaccess.monthly"
let threeMonthAccess = "com.newsgreatagain.newsgreatagain.allaccess.threemonth"
let yearlyMonthAccess = "com.newsgreatagain.newsgreatagain.allaccess.yearly"
let sixMonthAccess = "com.newsgreatagain.newsgreatagain.allaccess.sixmonth"


var isFreeFromAds: Bool {
    return UserDefaults.standard.bool(forKey: UserDefaultKey.purchased.rawValue)
}
