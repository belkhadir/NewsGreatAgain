//
//  LineView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class LineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 1).isActive = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
