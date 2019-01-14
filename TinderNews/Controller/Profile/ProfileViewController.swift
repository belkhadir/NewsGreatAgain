//
//  ProfileViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    fileprivate let getNewsplusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.backgroundColor = UIColor.black.cgColor
        button.setTitle("MY NEWS PLUS", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        
        let topView = UIView()
        let bottomView = UIView()
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        
        let safeArea = view.safeAreaLayoutGuide
        stackView.autoLayout(topAnchor: safeArea.topAnchor, bottomAnchor: safeArea.bottomAnchor, leadingAnchor: safeArea.leadingAnchor, trailingAnchor: safeArea.trailingAnchor)
        
    }

}
