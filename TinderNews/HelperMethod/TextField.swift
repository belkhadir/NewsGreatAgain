//
//  TextField.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/25/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

func makeTextField(placeHolder: String) -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = placeHolder
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
    textField.leftView = paddingView
    textField.leftViewMode = .always
    return textField
}

