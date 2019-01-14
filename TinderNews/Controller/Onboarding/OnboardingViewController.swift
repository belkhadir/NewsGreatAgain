//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/12/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {

    
    enum Section: CaseIterable {
        case one
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    /// Configure MainTableViewController After getting city
    fileprivate func preparNewController(at page: Int) -> PageViewController{
        let pageController = PageViewController()
        pageController.page = page
        return pageController
    }

    
    func preparePageController() {
        
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentLearnPage = viewController as? PageViewController
            , currentLearnPage.page! > 0 else{
                return nil
        }
        
        let nextPage = currentLearnPage.page! - 1
        
        return preparNewController(at: nextPage)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentLearnPage = viewController as?  PageViewController
            , currentLearnPage.page! < Section.allCases.count - 1 else{
                return nil
        }
        let nextPage = currentLearnPage.page! + 1
        return preparNewController(at: nextPage)
    }
    
    
}
