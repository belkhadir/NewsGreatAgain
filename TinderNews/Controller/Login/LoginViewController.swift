//
//  LoginViewController.swift
//  TinderNews
//
//  Created by xxx on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    fileprivate var login = Login.none
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func didTapEmail(){
        let user = User(email: "", password: "")
        login = Login.email(user: user)
        login.userDidlogin(delegate: self)
    }
    
    @objc func didTapFacebook() {
        login = Login.facebook
        login.userDidlogin(delegate: self)
    }
    
    @objc func didTapGoolge() {
        login = Login.google
        login.userDidlogin(delegate: self)
    }

}

extension LoginViewController: LoginDelegate {
    func didFailToLoginIn(error: Error) {
        
    }
    
    func didStart() {
        
    }
    
    func didLoginIn(user: User, token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKey.token.rawValue)
    }
    
    
}
