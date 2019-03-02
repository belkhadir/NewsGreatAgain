//
//  NavigationStackView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class NavigationStackView: UIStackView {

//    let settingsButton = UIButton(type: .custom)
    let logoButton = UIButton(type: .custom)
    let favoriteButton = UIButton(type: .custom)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        settingsButton.setImage(UIImage(named: "support")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        settingsButton.tintColor = UIColor.lightGray
//        settingsButton.tintColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        
        logoButton.setImage(UIImage(named: "LOGO-RED-HEADER")?.withRenderingMode(.alwaysTemplate), for: .normal)
        logoButton.tintColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        
        favoriteButton.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        favoriteButton.tintColor = UIColor.lightGray
//        favoriteButton.tintColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        let label = UILabel(frame: .zero)
//        label.text = "Head Lines"
//        label.textColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
//        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)
//
//        [settingsButton,
         [logoButton, favoriteButton].forEach { addArrangedSubview($0) }
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 64, bottom: 0, right: 64)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
    }


}
