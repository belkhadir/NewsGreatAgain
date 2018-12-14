//
//  BuyView.swift
//  TinderNews
//
//  Created by xxx on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class BuyView: UIView {

    fileprivate let segementControll: UISegmentedControl = {
        let segement = UISegmentedControl(frame: .zero)
        
        segement.translatesAutoresizingMaskIntoConstraints = false
        return segement
    }()
    
    
    fileprivate let continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let noThanksButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        let topView = UIView()
        let bottomView = UIView()
        
        let overAllStack = UIStackView(arrangedSubviews: [topView, bottomView])
        overAllStack.translatesAutoresizingMaskIntoConstraints = false
        overAllStack.alignment = .fill
        overAllStack.distribution = .fillEqually
        overAllStack.axis = .horizontal
        
        
    }
}
