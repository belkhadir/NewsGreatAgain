//
//  BuyController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/15/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit


class BuyController {
    
    fileprivate let blackView = BuyView()
    
    
    /// Mark:- Present the buy view in the main UIWindow
    func present(view: UIView) {
        if let window = UIApplication.shared.keyWindow {
            blackView.frame = window.bounds
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(view)
            
            blackView.frame = window.frame
            window.addSubview(view)
        }
    }
    
    
    /// Mark:- Remove the buy view from the UIWindow
    func dismiss(view: UIView) {
        
    }
    
}
