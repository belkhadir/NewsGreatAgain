//
//  NavigationStackView.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class NavigationStackView: UIStackView {

    fileprivate let settingsButton = UIButton(type: .system)
    fileprivate let logoButton = UIButton(type: .system)
    fileprivate let favoriteButton = UIButton(type: .system)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        

        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
    }


}
