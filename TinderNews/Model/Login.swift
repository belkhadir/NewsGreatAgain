//
//  Login.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

enum Login {
    case email(user: User)
    case facebook
    case google
    case none
    
    func userDidlogin(delegate: LoginDelegate) {
        switch self {
        case .email(let user):
            didlogin(using: user, delegate: delegate)
        case .facebook:
            didLoginUsingFacebook(delegate)
        case .google:
            didLoginUsinGoogle(delegate)
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
                delegate.didLoginIn(user: value)
            }
        }
    }
    
    fileprivate func didLoginUsingFacebook(_ delegate: LoginDelegate) {
        
        let loginManager = LoginManager(loginBehavior: .native, defaultAudience: .everyone)
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: UIViewController()) { (result) in
            switch result {
            case .failed(let error):
                delegate.didFailToLoginIn(error: error)
            case .success(_, _, let accessToken):
                let graphRequest: GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"first_name,email, picture.type(large)"], accessToken: accessToken, httpMethod: .GET)
                graphRequest.start({ (response, result) in
                    switch result {
                    case .failed(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                        let user = User(email: "", password: "")
                        UserService.register(user: user, completion: { (r) in
                            switch r {
                            case .failure(let error):
                                delegate.didFailToLoginIn(error: error)
                            case .success(let value):
                                self.didlogin(using: user, delegate: delegate)
                            }
                        })
                    }
                })

            case .cancelled:
                return
            }
        }
    }
    
    fileprivate func didLoginUsinGoogle(_ delegate: LoginDelegate) {
        
    }
}

