//
//  SocialMediaStack.swift
//  TinderNews
//
//  Created by xxx on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class SocialMediaStack: UIStackView {

    let facebookLogin: UIButton = {
        return configureButton(button: "LOGIN WITH FACEBOOK", backgroundColor: UIColor.blue)
    }()
    
    let googleLogin: UIButton = {
        return configureButton(button: "LOGIN WITH GOOGLE", backgroundColor: UIColor.red)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        facebookLogin.translatesAutoresizingMaskIntoConstraints = false
        facebookLogin.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        [facebookLogin, googleLogin].forEach { addArrangedSubview($0) }
        
        alignment = .fill
        distribution = .fillEqually
        axis = .vertical
        spacing = 16
    }

    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
