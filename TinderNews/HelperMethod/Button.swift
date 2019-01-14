//
//  Button.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/23/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit



func configureButton(button name: String,backgroundColor: UIColor) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setAttributedTitle(NSAttributedString(string: name, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.white ]), for: .normal)
    button.layer.backgroundColor = backgroundColor.cgColor
    button.layer.cornerRadius = 5
    button.clipsToBounds = true
    return button
}
