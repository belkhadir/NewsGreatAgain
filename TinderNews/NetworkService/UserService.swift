//
//  UserService.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation



class UserService {
    
    
    
    static func loginTheUser(using email: User,
                             completion: @escaping (_ result: Result<UserResponse, DataResponseError>)->Void) {
        
        
    }
    
    static func addTofavorite(article: Article) {
        if let token = UserDefaults.standard.string(forKey: Key.token.rawValue), let userID = UserDefaults.standard.string(forKey: Key.userID.rawValue) {
            
            
        }
    }
    
    
}
