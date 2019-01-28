//
//  LoginResponse.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class LoginResponse: Codable {
    var id: Int
    var token: String?
    var userID: Int?
    var reason: String?
    var error: Bool?
    var fullName: String?
    var email: String?
}



//extension LoginResponse: CustomDebugStringConvertible {
//    var debugDescription: String {
//        return "id: \(id.debugDescription)" + "token: \(token?.debugDescription)" + "userID: \(userID)"
//    }
//}
