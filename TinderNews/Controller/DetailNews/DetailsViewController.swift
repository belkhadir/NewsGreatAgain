//
//  DetailsViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleMobileAds

class DetailsViewController: UIViewController {
    fileprivate let extraSwipingHeight: CGFloat = 80
    fileprivate var bannerView: GADBannerView!
    
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.delegate = self
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }else {
            
        }
        
        return scrollView
    }()
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    fileprivate let label = UILabel()
    
    var article: Article?
    
    let closeButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTarget()
        setuplayout()
    }
    
    fileprivate func addTarget() {
        closeButton.addTarget(self, action: #selector(tapClose), for: .touchUpInside)
    }
    
    @objc func tapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    

    fileprivate func setuplayout() {
        view.backgroundColor = .white
        
        
        
        closeButton.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
//        closeButton.setImage(UIImage(named: "cancel")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        closeButton.setAttributedTitle(NSAttributedString(string: "X", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        scrollView.fillSuperView()
        
        
        guard let article = article , let urlString = article.urlToImage else { return }
        let url = URL(string: urlString)
        imageView.sd_setImage(with: url, completed: nil)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        
        scrollView.addSubview(imageView)
        if #available(iOS 11.0, *) {
            let safeArea = view.safeAreaLayoutGuide
            closeButton.autoLayout(topAnchor: safeArea.topAnchor, bottomAnchor: nil, leadingAnchor: nil, trailingAnchor: safeArea.trailingAnchor, inset: .init(top: 8, left: 0, bottom: 0, right: 8))
            
        }else {
            closeButton.autoLayout(topAnchor: view.topAnchor, bottomAnchor: nil, leadingAnchor: nil, trailingAnchor: view.trailingAnchor, inset: .init(top: 8, left: 0, bottom: 0, right: 8))
        }
        
        
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        closeButton.layer.cornerRadius = 30 / 2
        closeButton.clipsToBounds = true
        
        scrollView.addSubview(label)
        label.autoLayout(topAnchor: imageView.bottomAnchor, bottomAnchor: scrollView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, inset: .init(top: 16, left: 16, bottom: 100, right: 16))
        label.numberOfLines = 0
        addTextAttribute(artilce: article)
        if !isFreeFromAds {
            setupAdmob()
        }
        
    }

    func addTextAttribute(artilce: Article) {
        let text = NSMutableAttributedString(string: artilce.title!, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21, weight: UIFont.Weight.black), NSAttributedString.Key.foregroundColor: UIColor.black])
        if let author = artilce.author {
            text.append(NSAttributedString(string: "\n\(author)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.5)]))
        }
        if let description = artilce.description {
            text.append(NSAttributedString(string: "\n\nDescription:\n\(description)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)]))
        }
        
        if let detail = artilce.content {
            let newText = detail.components(separatedBy: "…")[0]
            
            text.append(NSAttributedString(string: "\n\nDetails: \n\(newText)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)]))
        }
        label.attributedText = text
    }
    
    fileprivate func setupAdmob() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(bannerView)
        if #available(iOS 11, *) {
            bannerView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            bannerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            bannerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }else {
            bannerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }

        bannerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        bannerView.adUnitID = ADMOB_BANNER_ID
        bannerView.rootViewController = self
        
        bannerView.delegate = self
        
        bannerView.load(GADRequest())
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width + extraSwipingHeight)
    }
}
// Mark: - Scroll delegate
extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeY = -scrollView.contentOffset.y
        var width = view.frame.width + changeY * 2
        width = max(view.frame.width, width)
        imageView.frame = CGRect(x: min(0, -changeY), y: min(0, -changeY), width: width, height: width + extraSwipingHeight)
    }
}


// Mark: - Banner Delegate
extension DetailsViewController: GADBannerViewDelegate {
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
