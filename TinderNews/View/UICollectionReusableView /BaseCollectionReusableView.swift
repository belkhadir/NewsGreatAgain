//
//  BaseCollectionReusableView.swift
//  TinderNews
//
//  Created by xxx on 11/22/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setupLayout() {
    
    }
}
