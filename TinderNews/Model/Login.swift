//
//  Login.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation
//import FacebookLogin
//import FacebookCore

enum Login {
    case email(user: User)
    case facebook
    case google
    case none
    case register(user: User)
    
    func userDidlogin(delegate: LoginDelegate) {
        delegate.didStart()
        switch self {
        case .email(let user):
            didlogin(using: user, delegate: delegate)
        case .facebook:
            didLoginUsingFacebook(delegate)
        case .google:
            didLoginUsinGoogle(delegate)
        case .register(let user):
            registerUser(using: user, delegate)
        case .none: return
        }
    }
    
    static var paramer = ["fields":"email,first_name,last_name,picture.width(1000).height(1000),birthday,gender"]
    
    fileprivate func didlogin(using email: User, delegate: LoginDelegate) {
        UserService.login(user: email) { (response) in
            switch response {
            case .failure(let error):
                delegate.didFailToLoginIn(error: error)
            case .success(let value):
                if let _ = value.error, let reason = value.reason {
                    let error = NSError(domain:  "User" + reason, code: 0, userInfo: nil)
                    delegate.didFailToLoginIn(error: error)
                }
                delegate.didLoginIn(user: value)
            }
        }
    }
    
    fileprivate func didLoginUsingFacebook(_ delegate: LoginDelegate) {
        
//        let loginManager = LoginManager(loginBehavior: .native, defaultAudience: .everyone)
//        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: UIViewController()) { (result) in
//            switch result {
//            case .failed(let error):
//                delegate.didFailToLoginIn(error: error)
//            case .success(_, _, let accessToken):
//                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"], accessToken: accessToken, httpMethod: .GET)
//                graphRequest.start({ (response, result) in
//                    switch result {
//                    case .failed(let error):
//                        print(error)
//                    case .success(let graphResponse):
//
//                        if let responseDictionary = graphResponse.dictionaryValue {
//                            print(responseDictionary)
//                            let firstNameFB = responseDictionary["first_name"] as? String
//                            let lastNameFB = responseDictionary["last_name"] as? String
//                            let socialIdFB = responseDictionary["id"] as? String
//                            let genderFB = responseDictionary["gender"] as? String
//                            let pictureUrlFB = responseDictionary["picture"] as? [String:Any]
//                            let photoData = pictureUrlFB!["data"] as? [String:Any]
//                            let photoUrl = photoData!["url"] as? String
//                            print(firstNameFB, lastNameFB, socialIdFB, genderFB, photoUrl)
//                        }
////                        let user = User(email: "", password: "", fullName: "")
////                        UserService.register(user: user, completion: { (r) in
////                            switch r {
////                            case .failure(let error):
////                                delegate.didFailToLoginIn(error: error)
////                            case .success(let value):
////                                self.didlogin(using: user, delegate: delegate)
////                            }
////                        })
//                    }
//                })
//
//            case .cancelled:
//                return
//            }
//        }
    }
    
    fileprivate func registerUser(using user: User,_ delegate: LoginDelegate) {
        UserService.register(user: user) { (result) in
            switch result {
            case .failure(let error):
                delegate.didFailToLoginIn(error: error)
            case .success:
                self.didlogin(using: user, delegate: delegate)
            }
        }
    }
    
    fileprivate func didLoginUsinGoogle(_ delegate: LoginDelegate) {
        
    }
}

