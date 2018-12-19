//
//  CardCollectionViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    internal let cornerRadius: CGFloat = 5
    
    // Mark: - Initilise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    internal func setupLayout() {
        contentView.layer.cornerRadius = cornerRadius
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOffset = CGSize(width: -1, height: 2)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.layer.shadowOpacity = 0.2
    }
}
