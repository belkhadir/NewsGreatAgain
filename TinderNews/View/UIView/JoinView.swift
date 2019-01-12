//
//  JoinView.swift
//  TinderNews
//
//  Created by xxx on 1/12/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class JoinView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        setupLayout()
        addTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
        setupLayout()
        addTarget()
    }
    
    let loginButtonStack = LoginRegisterStackView()
    
    fileprivate let logoImage = UIImageView(image: UIImage(named: "NLOGO")!)
    
    weak var rootController: UIViewController?
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Join\n News Great Again (it's free)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 35), NSAttributedString.Key.foregroundColor: UIColor.white])
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func addTarget() {
        loginButtonStack.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        loginButtonStack.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
    }
    
    @objc func handleRegister() {
        let registerVC = RegisterViewController()
        rootController?.present(registerVC, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        let login = LoginViewController()
        rootController?.present(login, animated: true, completion: nil)
    }
    
    let gradientLayer = CAGradientLayer()
    
    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.contentMode = .scaleAspectFill
        logoImage.clipsToBounds = true
        
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        titleView.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -16).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        let overAllStackView = UIStackView(arrangedSubviews: [logoImage,titleView, loginButtonStack])
        overAllStackView.alignment = .fill
        overAllStackView.distribution = .equalSpacing
        overAllStackView.axis = .vertical
        
        addSubview(overAllStackView)
        
        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
        
    }
    
    
    func addLoginRegisterButton() {
        
        
    }

    

}
