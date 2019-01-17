//
//  Unlocked.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/17/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import Foundation



var isUnlocked: Bool {
    
    let subscription = UserDefaults.standard.bool(forKey: UserDefaultKey.subscription.rawValue)
    if subscription == true {
        return true
    }
    
    guard let date = UserDefaults.standard.object(forKey: UserDefaultKey.day.rawValue) as? Date else {
        return false
    }
    
    if Calendar.current.compare(Date(), to: date, toGranularity: .day) == .orderedDescending {
        return true
    }
    
    return false
}
