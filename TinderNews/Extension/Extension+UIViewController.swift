//
//  Extension+UIViewController.swift
//  TinderNews
//
//  Created by xxx on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//


import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
