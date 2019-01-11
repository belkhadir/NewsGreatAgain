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
            sendRequest(for: LoginResponse.self, host: "newsgreatagain.com", path: EndPath.login, port: 8080, query: [], httpMethod: .post, json: json) { completion($0) }
        }
        
    }
    
    static func register(user: User,
                         completion: @escaping (_ result: Result<UserResponse, DataResponseError>)->Void)  {
        if let json = user.dictionary {
            sendRequest(for: UserResponse.self, host: "newsgreatagain.com", path: EndPath.register, port: 8080, query: [], httpMethod: .post, json: json) { completion($0) }
        }
    }
    
    static func logout(completion:  @escaping (_ result: Result<Any, DataResponseError>)->Void){
        guard let bear = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue) else { return }
        sendRequestStatus(host: "newsgreatagain.com", path: EndPath.logout, port: 8080, query: [], httpMethod: HTTPMethod.get, bear: bear) { (result) in
            completion(result)
        }
    }
    
    static func referal() {
        guard let invitedBy = UserDefaults.standard.string(forKey: UserDefaultKey.invitedBy.rawValue),
        let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue),
        let bear = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue) else { return }
        let path = "\(userID)/" + EndPath.referal.rawValue + "/\(invitedBy)"
        sendRequest(for: HTTPStatus.self, host: EndURL.host.rawValue, stringPath: path, port: 8080, query: [], httpMethod: HTTPMethod.post, bear:  bear) { (result) in
            print(result)
        }
    }
    
    static func userDidBuy() {
        guard let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue),
        let bear = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue) else { return }
        let path = "\(userID)/" + EndPath.purchase.rawValue
        sendRequest(for: HTTPStatus.self, host: EndURL.host.rawValue, stringPath: path, port: 8080, query: [], httpMethod: HTTPMethod.post, bear: bear) { (result) in
            print(result)
        }
    }
}
