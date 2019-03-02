//
//  MainTabBarViewController.swift
//  TinderNews
//
//  Created by xxx on 3/2/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    fileprivate func configure() {
        let newsController = NewsViewController()
        newsController.tabBarItem = UITabBarItem(title: "News", image: UIImage(named: ""), tag: 0)
        
        
//        let favoriteController =
//        let navigation = UINavigationController(rootViewController: <#T##UIViewController#>)
    
        viewControllers = [newsController]
    }
    


}
