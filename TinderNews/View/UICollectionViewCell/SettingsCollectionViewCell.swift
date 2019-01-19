//
//  SettingsCollectionViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import Firebase


class SettingsCollectionViewCell: UICollectionViewCell {
    
    fileprivate let imageView = UIImageView()
    
    fileprivate let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    fileprivate let orLabel: UILabel = {
        let label = UILabel()
        label.text = "Share with 3 friends and get app free from ads"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    fileprivate let settingsButton = UIButton(type: .system)
    fileprivate let aboutButton = UIButton(type: .system)
    fileprivate let inviteButton = UIButton(type: .system)
    fileprivate let subscribeButton = UIButton(type: .system)
    
    weak var rootController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let isLogged = UserDefaults.standard.bool(forKey: UserDefaultKey.isLogged.rawValue)
        
        if let fullName = UserDefaults.standard.string(forKey: UserDefaultKey.fullName.rawValue) {
            fullNameLabel.text = fullName
        }
        
        if isLogged == false {
            addLoginView()
        }else {
            configureButton()
            setupLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
        setupLayout()
    }
    
    fileprivate func setButtonConfiguration(button: UIButton, text: String) {
        button.layer.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor
        button.setAttributedTitle(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        button.layer.cornerRadius = 60/2
        button.clipsToBounds = true
    }
    
    fileprivate func configureButton() {
        subscribeButton.addTarget(self, action: #selector(handleSubscribe), for: .touchUpInside)
        inviteButton.addTarget(self, action: #selector(sharetheApp), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        settingsButton.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        aboutButton.addTarget(self, action: #selector(handleAbout), for: .touchUpInside)
        aboutButton.setImage(UIImage(named: "about")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        inviteButton.setAttributedTitle(NSAttributedString(string: "SHARE THE APP ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)]), for: .normal)
        
        inviteButton.layer.backgroundColor = UIColor.white.cgColor
        inviteButton.layer.cornerRadius = 60/2
        inviteButton.clipsToBounds = true
        inviteButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1).cgColor
        inviteButton.layer.borderWidth = 1
        
        setButtonConfiguration(button: subscribeButton, text: "News Great Again + PLUS")
    }
    
    fileprivate func addLoginView() {
        let joinView = JoinView()
        joinView.rootController = rootController
        
        addSubview(joinView)
        
        joinView.fillSuperView()
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
//        addSubview(removeAdsButton)
//        let safe = safeAreaLayoutGuide
        
        let topView = UIView()
        let bottomView = UIView()
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "placeholderProfile")
//        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        
        addSubview(stackView)
        
        topView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/2).isActive = true
        
        stackView.fillSuperView()
        
        let settingsLabel = UILabel()
        settingsLabel.text = "SETTINGS"
        settingsLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .regular)
        settingsLabel.textColor = UIColor.lightGray
        
        let aboutLabel = UILabel()
        aboutLabel.text = "ABOUT"
        aboutLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 15, weight: .regular)
        aboutLabel.textColor = UIColor.lightGray
        
        
        let settingsStack = UIStackView(arrangedSubviews: [settingsButton, settingsLabel])
        settingsStack.axis = .vertical
        settingsStack.distribution = .fill
        settingsStack.alignment = .center
        
        
        let aboutStack = UIStackView(arrangedSubviews: [aboutButton, aboutLabel])
        aboutStack.axis = .vertical
        aboutStack.distribution = .fill
        aboutStack.alignment = .center
        
        let overAllButton = UIStackView(arrangedSubviews: [settingsStack, aboutStack])
        overAllButton.alignment = .fill
        overAllButton.axis = .horizontal
        overAllButton.distribution = .fill
        overAllButton.spacing = 32
        
        let topStack = UIStackView(arrangedSubviews: [imageView, fullNameLabel, overAllButton])
        topStack.alignment = .center
        topStack.distribution = .fill
        topStack.axis = .vertical
        topStack.spacing = 16
        
        topView.addSubview(topStack)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
            //
        topStack.autoLayout(topAnchor: topView.topAnchor, bottomAnchor: topView.bottomAnchor, leadingAnchor: topView.leadingAnchor, trailingAnchor: topView.trailingAnchor, inset: .init(top: 32, left: 32, bottom: 32, right: 32))

        
        let stackReferal = UIStackView(arrangedSubviews: [inviteButton, orLabel, subscribeButton])
        stackReferal.alignment = .fill
        stackReferal.axis = .vertical
        stackReferal.distribution = .fill
        stackReferal.spacing = 8
        
        // Bottom
        bottomView.addSubview(stackReferal)


        inviteButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        stackReferal.autoLayout(topAnchor: bottomView.topAnchor, bottomAnchor: bottomView.bottomAnchor, leadingAnchor: bottomView.leadingAnchor, trailingAnchor: bottomView.trailingAnchor, inset: .init(top: 32, left: 32, bottom: 64, right: 32))
    }
    
    
    @objc func handleSettings() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        
        let settings = storyBoard.instantiateViewController(withIdentifier: SettingsTableViewController.reuseIdentifier) as! SettingsTableViewController
        let navigation = UINavigationController(rootViewController: settings)
        DispatchQueue.main.async {
            self.rootController?.present(navigation, animated: true, completion: nil)
        }
        
    }
    
    @objc func handleAbout() {
        
    }
    
    
    @objc func handleSubscribe() {
        let storyBoard = UIStoryboard(name: "Subscription", bundle: nil)
        
        let subscriptions = storyBoard.instantiateViewController(withIdentifier: SubscribeViewController.reuseIdentifier) as! SubscribeViewController
        let navigation = UINavigationController(rootViewController: subscriptions)
        DispatchQueue.main.async {
            self.rootController?.present(navigation, animated: true, completion: nil)
        }
    }
    
    @objc func sharetheApp() {
        createLink()
    }
    
    // [Start Invite start]
    func inviteFinished(withInvitations invitationIds: [String], error: Error?) {
        if let error = error {
            print("Failed: " + error.localizedDescription)
        } else {
            print("\(invitationIds.count) invites sent")
        }
    }
    // [End Invite finished]
    
    // [Start Create Link]
    func createLink() {
        guard let uid = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else { return }
        let link = URL(string: "https://newsgreatagain.com/referal?invitedby=\(uid)")
        let referralLink = DynamicLinkComponents(link: link!, domain: "newsgreatagain.page.link")
        
        referralLink.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.newsgreatagain.newsgreatagain")
        referralLink.iOSParameters?.minimumAppVersion = "1.0"
        referralLink.iOSParameters?.appStoreID = "1444359121"
        
//        referralLink.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.android")
//        referralLink.androidParameters?.minimumVersion = 125
        
        referralLink.shorten { (shortURL, warnings, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let shortURL = shortURL {
                print(shortURL)
                let activite = UIActivityViewController(activityItems: ["News great again, it's was never easy to read top sotries.\n Together we makes news great again. ",shortURL], applicationActivities: nil)
                guard let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else { return }
                Analytics.logEvent(AnalyticsEventCampaignDetails, parameters: [AnalyticsParameterSource: "userID-\(userID)"])
                
                DispatchQueue.main.async {
                    self.rootController?.present(activite, animated: true, completion: nil)
                }
            }
        }
    }
}

