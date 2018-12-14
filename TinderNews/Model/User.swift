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
    internal let password: String?
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

extension User {
    var json: [String: Any] {
        return []
    }
}
