//
//  LoginRegisterStackView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/12/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class LoginRegisterStackView: UIStackView {

    let registerButton = UIButton(type: .system)
    let loginButton = UIButton(type: .system)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        [registerButton, loginButton].forEach { addArrangedSubview($0) }
        
        alignment = .fill
        distribution = .fillEqually
        axis = .vertical
        spacing = 16
        
        
        registerButton.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1).cgColor
        registerButton.setTitleColor(.white, for: .normal)
        
        registerButton.setAttributedTitle(NSAttributedString(string: "REGISTER", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        
        loginButton.setAttributedTitle(NSAttributedString(string: "LOGIN", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)

        loginButton.layer.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1).cgColor
        
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
