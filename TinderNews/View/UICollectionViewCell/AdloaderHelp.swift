//
//  AdloaderHelp.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdloaderHelp {
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    
    /// The number of native ads to load (between 1 and 5 for this example).
    let numAdsToLoad = 5
    
    /// The ad loader that loads the native ads.
    var adLoader: GADAdLoader!
    
    let request = GADRequest()
    
    weak var viewController: UIViewController?
    weak var adsCollectionViewCell: AdsCollectionViewCell?
    init() {
        let options = GADMultipleAdsAdLoaderOptions()
        options.numberOfAds = numAdsToLoad
        
        // Prepare the ad loader and start loading ads.
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: viewController,
                               adTypes: [.unifiedNative],
                               options: [options])
        adLoader.delegate = adsCollectionViewCell
        adLoader.load(request)
    }
}
