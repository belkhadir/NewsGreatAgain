//
//  JoinViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD

class JoinViewController: UIViewController {


    let loginButtonStack = LoginRegisterStackView()

    fileprivate let loading = JGProgressHUD(style: .dark)

    fileprivate let logoImage = UIImageView(image: UIImage(named: "NLOGO")!)

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Stop wasting time reading everyday news. It only wastes your time unnecessarily. Instead, go with the fast & intuitive News Great Again", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.white])
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupGradientLayer()
        setupLayout()
        addTarget()
//        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
//    func setupLayout() {
//        
//        let joinView = JoinView()
//        joinView.rootController = self
//        
//        view.addSubview(joinView)
//        
//        joinView.fillSuperView()
//    }

    fileprivate func addTarget() {
        loginButtonStack.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        loginButtonStack.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

    }

    @objc func handleRegister() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

    @objc func handleLogin() {
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }

    let gradientLayer = CAGradientLayer()

    fileprivate func setupGradientLayer() {
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        // make sure to user cgColor
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }

    fileprivate func setupLayout() {
        view.backgroundColor = .white
        logoImage.translatesAutoresizingMaskIntoConstraints = false

        logoImage.contentMode = .scaleAspectFit
//        logoImage.clipsToBounds = true

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

        view.addSubview(overAllStackView)

        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)

    }


    func addLoginRegisterButton() {


    }

}

