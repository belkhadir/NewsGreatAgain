//
//  UserService.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation



class UserService {
    
    
    
    static func login(user: User,
                             completion: @escaping (_ result: Result<LoginResponse, DataResponseError>)->Void) {
        if let json = user.dictionary {
            sendRequest(for: LoginResponse.self, host: "localhost", path: EndPath.login, port: 8080, query: [], httpMethod: .post, json: json) { completion($0) }
        }
        
    }
    

    
    static func register(user: User,
                         completion: @escaping (_ result: Result<UserResponse, DataResponseError>)->Void)  {
        if let json = user.dictionary {
            sendRequest(for: UserResponse.self, host: "localhost", path: EndPath.register, port: 8080, query: [], httpMethod: .post, json: json) { completion($0) }
        }
    }
    

    
}
