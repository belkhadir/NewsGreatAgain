//
//  PriceView.swift
//  TinderNews
//
//  Created by xxx on 1/23/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit
import StoreKit

class PriceView: UIView {

    var index = 0
    
    fileprivate let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 31, weight: UIFont.Weight.heavy)
        return label
    }()
    
    fileprivate let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "months"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    fileprivate let pricePermonth: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = UIColor.gray
        return label
    }()
    
   
    
    func configure(option: Subscription) {
//        guard let period = option.product.subscriptionPeriod?.unit else {
//            return 
//        }
//        let text = option.product.localizedTitle.components(separatedBy: " ")
//        durationLabel.text = text[0]
//        monthLabel.text = text[1]
//        pricePermonth.text = option.formattedPrice
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
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        stackView.fillSuperView()
    }
    
    func isSelected() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
    }
    
}
