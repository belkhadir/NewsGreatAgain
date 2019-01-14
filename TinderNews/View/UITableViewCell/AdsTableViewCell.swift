//
//  AdsTableViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import GoogleMobileAds


class AdsTableViewCell: UITableViewCell {
    fileprivate var bannerView: GADBannerView!
    
    weak var rootController: UIViewController?
    let adUnitID = "ca-app-pub-3940256099942544/3986624511"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = rootController
        
        bannerView.delegate = self
        
        bannerView.load(GADRequest())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

}

extension AdsTableViewCell: GADBannerViewDelegate{
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
        self.bannerView = bannerView
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
