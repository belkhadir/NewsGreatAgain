//
//  NavigationStackView.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class NavigationStackView: UIStackView {

    let settingsButton = UIButton(type: .system)
    let logoButton = UIButton(type: .system)
    let favoriteButton = UIButton(type: .system)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        settingsButton.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        logoButton.setImage(UIImage(named: "LOGO-RED-HEADER")?.withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        [settingsButton, logoButton, favoriteButton].forEach { addArrangedSubview($0) }
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
    }


}
