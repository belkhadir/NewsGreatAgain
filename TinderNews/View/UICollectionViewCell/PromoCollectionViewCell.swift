//
//  PromoCollectionViewCell.swift
//  TinderNews
//
//  Created by xxx on 1/22/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell, Configurable {
    typealias T = SubscriptionViewController.Section
    
    
    func configure(cell with: SubscriptionViewController.Section) {
        benifitLabel.text = with.benifit
        imageView.image = with.image
//        backgroundColor = with.backgroundColor
    }
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Get News Great Again Plus+"
        label.font = UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.medium)
        label.textColor = UIColor.black
        return label
    }()
    
    fileprivate let imageView = UIImageView()
    
    fileprivate let benifitLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    
    fileprivate func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, benifitLabel])
        
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.fillSuperView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
