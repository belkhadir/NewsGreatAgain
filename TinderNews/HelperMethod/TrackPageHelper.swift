//
//  TrackPageHelper.swift
//  TinderNews
//
//  Created by xxx on 1/18/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import Foundation

struct TrackPageHelper {
    
    static func incrementpageCount() { // called from appdelegate didfinishLaunchingWithOptions:
        var appOpenCount = UserDefaults.standard.integer(forKey: UserDefaultKey.page.rawValue)
        appOpenCount += 1
        UserDefaults.standard.set(appOpenCount, forKey: UserDefaultKey.page.rawValue)
    }
    
    static var count: Int {
        return UserDefaults.standard.integer(forKey: UserDefaultKey.page.rawValue)
    }
    
    static func setToZero() {
        UserDefaults.standard.set(0, forKey: UserDefaultKey.page.rawValue)
    }
}
