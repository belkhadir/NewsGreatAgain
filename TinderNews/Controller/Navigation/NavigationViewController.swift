//
//  NavigationViewController.swift
//  TinderNews
//
//  Created by Belkahdir Anas on 12/24/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(handlePop))
        
    }
    
    @objc func handlePop() {
        popViewController(animated: true)
    }

}
