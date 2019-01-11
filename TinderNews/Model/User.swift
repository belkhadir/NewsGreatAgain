//
//  User.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class User: Codable {
    internal let email: String
    internal var password: String?
    internal var fullName: String?
    init(email: String, password: String, fullName: String?=nil) {
        self.email = email
        self.password = password
        self.fullName = fullName
    }
}
