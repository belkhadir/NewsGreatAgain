//
//  TinderDelegate.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit


protocol TinderDelegate: class {
    func didDislike(_ cell: UIView)
    func didLike(_ cell: UIView)
}
