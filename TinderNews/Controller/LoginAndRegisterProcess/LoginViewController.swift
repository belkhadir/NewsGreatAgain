//
//  LoginViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase

class LoginViewController: UIViewController {

    
    fileprivate var login = Login.none
    
    fileprivate let emailTextField = makeTextField(placeHolder: "Email")
    fileprivate let passwordTextField = makeTextField(placeHolder: "Password")
    fileprivate let loading = JGProgressHUD(style: .dark)
    fileprivate let titleView = UIView()
    fileprivate let seperator = SeperatorStackView()
    fileprivate lazy var emaiLoginStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
    fileprivate lazy var overAllStackView = UIStackView(arrangedSubviews: [titleView, seperator, emaiLoginStack, forgetPassword])
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(NSAttributedString(string: "LOGIN", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1).cgColor
        return button
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Welcome back", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.black])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    fileprivate let forgetPassword: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forget Password?", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.next
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = UIReturnKeyType.done
        
        addTarget()
        setupLayout()
        setupNotification()
        hideKeyboardWhenTappedAround()
        addDelegate()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardDismiss), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = frame.cgRectValue
        
//        let bottomSpace = view.frame.height - overAllStackView.frame.origin.y - overAllStackView.frame.height
        
        let difference = keyboardFrame.height - 150
        view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
    }
    
    @objc func handleKeyboardDismiss(notification: Notification) {
        view.transform = .identity
    }
    
    fileprivate func addTarget() {
        loginButton.addTarget(self, action: #selector(didTapEmail), for: .touchUpInside)
        
    }
    
    fileprivate func addDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        titleView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        emaiLoginStack.axis = .vertical
        emaiLoginStack.alignment = .fill
        emaiLoginStack.distribution = .fillEqually
        emaiLoginStack.spacing = 8
        
        
        overAllStackView.alignment = .fill
        overAllStackView.distribution = .equalSpacing
        overAllStackView.axis = .vertical
        
        view.addSubview(overAllStackView)
        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 32, left: 16, bottom: 150, right: 16)
    }
    
    @objc func didTapEmail(){
        if !verify {
            showAlert(title: "Error", message: "Please enter correct Value")
            return
        }
        let user = User(email: emailTextField.text!.lowercased(), password: passwordTextField.text!)
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(emailTextField) {
            passwordTextField.becomeFirstResponder()
        }else if textField.isEqual(passwordTextField) {
            if verify {
                didTapEmail()
            }else {
                showAlert(title: "Error", message: "Please enter correct Value")
            }
            
        }
        return true
    }

    var verify: Bool {
        return emailTextField.text?.isEmail ?? false && (passwordTextField.text?.count ?? 0 > 8)
    }
    
}


extension LoginViewController: LoginDelegate {
    func didFailToLoginIn(error: Error) {
        call {
            self.loading.dismiss()
            self.showAlert(title: "Error", message: "\(error.localizedDescription)")
        }
    }
    
    func didStart() {
        call {
            self.loading.show(in: self.view)
        }
    }
    
    func didLoginIn(user: LoginResponse) {
        Analytics.logEvent(AnalyticsEventLogin, parameters: nil)
        call {
            self.loading.dismiss()
        }
        
        if user.userID == nil || user.token == nil {
            call {
                self.showAlert(title: "Error", message: "Something went wrong please try later.")
            }
            return
        }
        UserDefaults.standard.set(user.userID, forKey: UserDefaultKey.userID.rawValue)
        UserDefaults.standard.set(user.token, forKey: UserDefaultKey.token.rawValue)
        UserDefaults.standard.set(user.email, forKey: UserDefaultKey.email.rawValue)
        UserDefaults.standard.set(true, forKey: UserDefaultKey.isLogged.rawValue)
        UserDefaults.standard.set(user.fullName, forKey: UserDefaultKey.fullName.rawValue)
        
    
        let main = MainViewController()
        call {
            self.present(main, animated: true, completion: nil)
        }
    }

}
