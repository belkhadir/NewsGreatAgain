//
//  UserResponse.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class UserResponse: User {
    var token: String
    
    init(email: String, password: String, token: String) {
        self.token = token
        super.init(email: email, password: password)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
