//
//  JoinViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

     fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Join News Great Again (it's free)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.black])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let memberLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Already a member?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        return label
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.setTitle("Log in", for: .normal)
        return button
    }()
    
    fileprivate let emailButton: UIButton = {
        return configureButton(button: "CONTINUE WITH EMAIL", backgroundColor: .blue)
    }()
    
    fileprivate let socialMediaStack = SocialMediaStack()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        addTarget()
    }
    

    fileprivate func addTarget() {
        emailButton.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc func handleEmail() {
        let registerVC = RegisterViewController()
        present(registerVC, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        let login = LoginViewController()
        present(login, animated: true, completion: nil)
    }
    
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        titleView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        let seperator = SeperatorStackView()
        
        
        let loginStack = UIStackView(arrangedSubviews: [memberLabel, loginButton])
        loginStack.axis = .horizontal
        loginStack.alignment = .center
        loginStack.distribution = .fill
        loginStack.spacing = 6
        loginStack.translatesAutoresizingMaskIntoConstraints = false
        
        let loginView = UIView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        loginView.addSubview(loginStack)
        loginStack.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        loginStack.centerYAnchor.constraint(equalTo: loginView.centerYAnchor).isActive = true
        
        
        let overAllStackView = UIStackView(arrangedSubviews: [titleView, socialMediaStack, seperator, emailButton, loginView])
        overAllStackView.alignment = .fill
        overAllStackView.distribution = .equalSpacing
        overAllStackView.axis = .vertical
        
        view.addSubview(overAllStackView)
        
        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 16, left: 16, bottom: 200, right: 16)
        
    }

}
