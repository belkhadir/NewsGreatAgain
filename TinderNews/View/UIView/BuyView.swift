//
//  BuyView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class BuyView: UIView {

    
    fileprivate lazy var segementControll: UISegmentedControl = {
        let segement = UISegmentedControl(frame: .zero)
        segement.translatesAutoresizingMaskIntoConstraints = false
        segement.addTarget(self, action: #selector(didChange), for: UIControl.Event.valueChanged)
        return segement
    }()
    
    
    fileprivate let continueButton: UIButton = {
        let button = GradientButton(frame: .zero)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let noThanksButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("NO THANKS", for: .normal)
        button.setTitleColor(UIColor.gray.withAlphaComponent(0.5), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let topView = UIView()
        let bottomView = UIView()
        
        let overAllStack = UIStackView(arrangedSubviews: [topView, bottomView])
        overAllStack.translatesAutoresizingMaskIntoConstraints = false
        overAllStack.alignment = .fill
        overAllStack.distribution = .fillEqually
        overAllStack.axis = .horizontal
        
        overAllStack.translatesAutoresizingMaskIntoConstraints = false
        
        overAllStack.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor)
        
        
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let stackButton = UIStackView(arrangedSubviews: [continueButton, noThanksButton])
        stackButton.distribution = .fillEqually
        stackButton.alignment = .fill
        stackButton.axis = .horizontal
        
        
        let bottomStackView = UIStackView(arrangedSubviews: [segementControll, stackButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.alignment = .fill
        bottomStackView.axis = .horizontal
        bottomStackView.distribution = .fillEqually

    }
    
    
    
}
