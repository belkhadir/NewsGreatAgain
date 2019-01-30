//
//  DetailNewsTableViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class DetailNewsTableViewController: UITableViewController {
    fileprivate var bannerView: GADBannerView!
    
    private enum Section: Int, CaseIterable {
        case title
        case author
        case ads
        case text
        
        var height: CGFloat {
            switch self {
            case .title:
                return 100
            default:
                return 0
            }
        }
        
        init(section: Int) {
            self.init(rawValue: section)!
        }
        init(at indextPath: IndexPath) {
            self.init(section: indextPath.section)
        }
    }
    
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAdmob()
        registerCell()
    }

    
    fileprivate func registerCell() {
        tableView.register(AdsTableViewCell.self, forCellReuseIdentifier: AdsTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Section.allCases.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch Section(section: section) {
        case .ads:
            return 1
        default:
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch Section(section: section) {
        case .title:
            guard let urlString = article?.urlToImage else {
                return nil
            }
            let url = URL(string: urlString)
            let header = DetailHeaderView()
            header.imageView.sd_setImage(with: url, completed: nil)
            return header
        default:
            return nil
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(at: indexPath) {
        case .ads:
            let cell = tableView.dequeueReusableCell(withIdentifier: AdsTableViewCell.reuseIdentifier, for: indexPath) as! AdsTableViewCell
            cell.rootController = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Section(at: indexPath).height
    }
    
    fileprivate func setupAdmob() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        

        bannerView.translatesAutoresizingMaskIntoConstraints = false
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(bannerView)
            if #available(iOS 11, *) {
                bannerView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor).isActive = true
                bannerView.leadingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leadingAnchor).isActive = true
                bannerView.trailingAnchor.constraint(equalTo: window.safeAreaLayoutGuide.trailingAnchor).isActive = true
                bannerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            }else {
                bannerView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
                bannerView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
                bannerView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
                bannerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            }
            
            
        }

        
        bannerView.adUnitID = ADMOB_BANNER_ID
        bannerView.rootViewController = self
        
        bannerView.delegate = self
        
        bannerView.load(GADRequest())
    }

}

extension DetailNewsTableViewController: GADBannerViewDelegate{
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

