//
//  GradientButton.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/15/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let startColor = UIColor.blue.cgColor
        let endColor = UIColor.blue.withAlphaComponent(0.4).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [startColor, endColor]
        
        gradient.startPoint = CGPoint(x: 0, y: 0.7)
        gradient.endPoint = CGPoint(x: 1, y: 0.7)
        
        layer.insertSublayer(gradient, at: 0)
        
        gradient.frame = rect
    }
 

}
