//
//  RegisterViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase

class RegisterViewController: UIViewController {

    fileprivate var register = Login.none
    
    fileprivate let fullNameTextField = makeTextField(placeHolder: "Full name")
    fileprivate let emailTextField = makeTextField(placeHolder: "Email")
    fileprivate let passwordTextField = makeTextField(placeHolder: "Create a password")
    fileprivate let button = configureButton(button: "JOIN NOW", backgroundColor: #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1))
    fileprivate let loading = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTarget()
        setupLayout()
        addDelegateToTextField()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    fileprivate func addTarget() {
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
    }
    
    @objc func handleRegister() {
        if verify {
            
            let user = User(email: emailTextField.text!, password: passwordTextField.text!, fullName: fullNameTextField.text!)
            register = Login.register(user: user)
            register.userDidlogin(delegate: self)
        }else {
            showAlert(title: "Error", message: "Please enter all correct information")
        }
    }
    
    fileprivate func addDelegateToTextField() {
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        fullNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let overAllStackView = UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, passwordTextField, button])
        overAllStackView.alignment = .fill
        overAllStackView.axis = .vertical
        overAllStackView.distribution = .fillEqually
        overAllStackView.spacing = 6
        
        view.addSubview(overAllStackView)
        overAllStackView.fillSuperView()
        
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 32, left: 16, bottom: view.frame.width , right: 16)
    }
   

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEqual(fullNameTextField) {
            textField.layer.borderColor = UIColor.black.cgColor
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        }else if textField.isEqual(emailTextField){
            textField.layer.borderColor = UIColor.black.cgColor
            fullNameTextField.layer.borderColor = UIColor.lightGray.cgColor
            passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        }else if textField.isEqual(passwordTextField) {
            textField.layer.borderColor = UIColor.black.cgColor
            emailTextField.layer.borderColor = UIColor.lightGray.cgColor
            fullNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(fullNameTextField) {
            emailTextField.becomeFirstResponder()
        }else if textField.isEqual(emailTextField) {
            passwordTextField.becomeFirstResponder()
        }else if textField.isEqual(passwordTextField) {
            
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if textField.isEqual(fullNameTextField) {
            changeTextFieldColor(textField: textField, state: text.isEmpty)
        }else if textField.isEqual(emailTextField) {
            changeTextFieldColor(textField: textField, state: text.isEmail)
        }else if textField.isEqual(passwordTextField) {
            changeTextFieldColor(textField: textField, state: text.count > 8)
         }
    }

    
    func changeTextFieldColor(textField: UITextField, state bool: Bool) {
        textField.layer.borderColor = bool ? UIColor.gray.cgColor: UIColor.red.cgColor
    }
    
    var verify: Bool {
        return (fullNameTextField.text?.count ?? 0 > 5)
            && emailTextField.text?.isEmail ?? false
            && passwordTextField.text?.count ?? 0 > 8
    }
}

extension RegisterViewController: LoginDelegate {
    func didFailToLoginIn(error: Error) {
        call {
            self.loading.dismiss()
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    func didStart() {
        call {
            self.loading.show(in: self.view)
        }
    }
    
    func didLoginIn(user: LoginResponse) {
        Analytics.logEvent(AnalyticsEventSignUp, parameters: nil)
        
        UserDefaults.standard.set(user.userID, forKey: UserDefaultKey.userID.rawValue)
        UserDefaults.standard.set(user.token, forKey: UserDefaultKey.token.rawValue)
        UserDefaults.standard.set(user.email, forKey: UserDefaultKey.email.rawValue)
        UserDefaults.standard.set(true, forKey: UserDefaultKey.isLogged.rawValue)
        UserDefaults.standard.set(user.fullName, forKey: UserDefaultKey.fullName.rawValue)
        UserService.referal()
        let vc = MainViewController()
        call {
            self.loading.dismiss()
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}
