//
//  Extension+String.swift
//  TinderNews
//
//  Created by xxx on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

extension String {
    var isEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    var toDouble: Double {
        return NumberFormatter().number(from: self)!.doubleValue
    }
}
