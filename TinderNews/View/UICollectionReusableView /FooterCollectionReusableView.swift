//
//  FooterCollectionReusableView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/22/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class FooterCollectionReusableView: BaseCollectionReusableView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    fileprivate let likeButton = createButton(image: UIImage(named: "like")!)
    fileprivate let disLikeButton = createButton(image: UIImage(named: "disLike")!)
    
    override func setupLayout() {
        super.setupLayout()
        
        let stackView = UIStackView(arrangedSubviews: [likeButton, disLikeButton])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, inset: .init(top: 16, left: 32, bottom: 16, right: 32))
        
    }
    
}
