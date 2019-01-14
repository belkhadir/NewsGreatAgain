//
//  UIView.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

extension UIView {
    
    func autoLayout(topAnchor: NSLayoutYAxisAnchor?, bottomAnchor: NSLayoutYAxisAnchor?,
                    leadingAnchor: NSLayoutXAxisAnchor?, trailingAnchor: NSLayoutXAxisAnchor?,
                    inset: UIEdgeInsets = .zero, height: (NSLayoutDimension, CGFloat)? = nil, width: (NSLayoutDimension, CGFloat)? = nil) {
        translatesAutoresizingMaskIntoConstraints  = false
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: inset.top).isActive = true
        }
        
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom).isActive = true
        }
        
        if let leadingAnchor = leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset.left).isActive = true
        }
        
        if let traillingAnchor = trailingAnchor {
            self.trailingAnchor.constraint(equalTo: traillingAnchor, constant: -inset.right).isActive = true
        }
        
        if let height = height{
            self.heightAnchor.constraint(equalTo: height.0, multiplier: height.1).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalTo: width.0, multiplier: width.1).isActive = true
        }
        
        
    }
    
    func fillSuperView() {
        guard let superview = superview?.safeAreaLayoutGuide else {
            return
        }
        autoLayout(topAnchor: superview.topAnchor, bottomAnchor: superview.bottomAnchor, leadingAnchor: superview.leadingAnchor, trailingAnchor: superview.trailingAnchor)
    }
    
}
