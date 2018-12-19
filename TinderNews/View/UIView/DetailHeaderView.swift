//
//  DetailHeaderView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit


class DetailHeaderView: UIView {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    fileprivate func setupLayout() {
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor)
        
    }
    
}
