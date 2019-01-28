//
//  PriceCollectionViewCell.swift
//  TinderNews
//
//  Created by xxx on 1/24/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
    
    
    fileprivate let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    fileprivate let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 9)
        label.text = "months"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    fileprivate let pricePermonth: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    
    func configure(option: Subscription) {
        durationLabel.text = "\(option.product.subscriptionPeriod?.unit.rawValue)"
        pricePermonth.text = option.formattedPrice
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [durationLabel, monthLabel, pricePermonth])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        stackView.fillSuperView()
    }
}
