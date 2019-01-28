//
//  DialogController.swift
//  StreamFirebase
//
//  Created by Belkhadir Anas on 11/29/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class DialogController {
    
    fileprivate let blackView = UIView()
    // Mark: - Show the dialog
    
    func showDialog(gradientView: BuyView) {
        if let window = UIApplication.shared.keyWindow {
            blackView.frame = window.bounds
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
            window.addSubview(blackView)
            
            gradientView.callback = {
                self.dismiss(gradienView: gradientView)
            }
            
            blackView.frame = window.frame
            window.addSubview(gradientView)
        }
    }
    
    // Mark: - Remove the dialog
    
    func dismiss(gradienView: BuyView) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let weakSelf = self else{
                return
            }
            weakSelf.blackView.alpha = 0
            gradienView.alpha = 0
        }) {
            [weak self]  (complet) in
            guard let weakSelf = self else{
                return
            }
            weakSelf.blackView.removeFromSuperview()
            gradienView.removeFromSuperview()
        }
    }
}
