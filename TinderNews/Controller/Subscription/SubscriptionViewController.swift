//
//  SubscriptionViewController.swift
//  TinderNews
//
//  Created by xxx on 1/29/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        options = SubscriptionService.shared.options
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleOptionsLoaded(notification:)),
                                               name: SubscriptionService.optionsLoadedNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handlePurchaseSuccessfull(notification:)),
                                               name: SubscriptionService.purchaseSuccessfulNotification,
                                               object: nil)
        setupLayout()
    }
    
    var options: [Subscription]?
    
    enum Section: CaseIterable {
        case ilimited
        case favorite
        case ads
        
        var image: UIImage {
            return UIImage()
        }
        
        var title: String {
            switch self {
            case .ilimited: return "Unlimited likes"
            case .favorite: return "Watch your Favorite"
            case .ads: return "Turn off adverts"
            }
        }
        
        var benifit: String {
            switch self {
            case .ilimited: return "Swipe right as much as you want."
            case .favorite: return "Save your favorite news."
            case .ads: return "Have fun swiping"
            }
        }
        
        var backgroundColor: UIColor {
            return UIColor()
        }
    }
    
    fileprivate let pageControl: UIPageControl = {
        let page = UIPageControl(frame: .zero)
        page.translatesAutoresizingMaskIntoConstraints = false
        page.currentPage = 0
        
        return page
    }()
    
    fileprivate let priceStackView = UIStackView()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        collection.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: PromoCollectionViewCell.reuseIdentifier)
        return collection
    }()
    
    fileprivate let continueButton: UIButton = {
        let button = GradientButton(frame: .zero)
        button.setTitle("No THANKS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return button
    }()
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var callback: (()->Void)?
    
    @objc func handleOptionsLoaded(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.options = SubscriptionService.shared.options
            guard let option =  SubscriptionService.shared.options else {
                return
            }
            var index = 0
            var x: CGFloat =  0
            let width: CGFloat = (self?.view.frame.width ?? 0)/4
            option.forEach{ o in
                let button = UIButton(frame:  CGRect(x: x, y: 0, width: width, height:100))
                button.setAttributedTitle(self?.getAttributeString(option: o), for: .normal)
                button.tag = index
                button.titleLabel?.textAlignment = .center
                button.titleLabel?.lineBreakMode = .byCharWrapping
                button.addTarget(self, action: #selector(self?.handleSegement(sender:)), for: .touchUpInside)
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.blue.cgColor
                self?.priceStackView.addArrangedSubview(button)
                index = index + 1
                x = x + width
            }
            
            
        }
    }
    
    @objc func handleSegement(sender: UIButton) {
        let index = sender.tag
        guard let option = options?[index] else { return }
        SubscriptionService.shared.purchase(subscription: option)
    }
    
    @objc func handlePurchaseSuccessfull(notification: Notification) {
        UserDefaults.standard.set(true, forKey: UserDefaultKey.unlock.rawValue)
        //        DispatchQueue.main.async { [weak self] in
        //            self?.tableView.reloadData()
        //Dismiss the view
        //        }
    }
    
    fileprivate func setupLayout() {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.groupTableViewBackground
        
        let overAllStack = UIStackView(arrangedSubviews: [collectionView, bottomView])
        overAllStack.translatesAutoresizingMaskIntoConstraints = false
        overAllStack.alignment = .fill
        overAllStack.distribution = .fill
        overAllStack.axis = .vertical
        
        view.addSubview(overAllStack)
        
        overAllStack.fillSuperView()
        
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3/5).isActive = true
        
        
        
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.layer.cornerRadius = 50/2
        continueButton.clipsToBounds = true
        
        priceStackView.alignment = .fill
        priceStackView.axis = .horizontal
        priceStackView.distribution = .fillEqually
        
        let continueView = UIView()
        continueView.backgroundColor = .white
        
        let bottomStackView = UIStackView(arrangedSubviews: [priceStackView, continueView])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.alignment = .fill
        bottomStackView.axis = .vertical
        bottomStackView.distribution = .fillEqually
        
        bottomView.addSubview(bottomStackView)
        bottomStackView.fillSuperView()
        
        priceStackView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/2).isActive = true
        continueView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 1/2).isActive = true
        
        continueView.addSubview(continueButton)
        continueButton.centerXAnchor.constraint(equalTo: continueView.centerXAnchor).isActive = true
        continueButton.centerYAnchor.constraint(equalTo: continueView.centerYAnchor).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: continueView.leadingAnchor, constant: 32).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: continueView.trailingAnchor, constant: -32).isActive = true
        
        
        collectionView.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 64).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -64).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
//        overAllStack.isLayoutMarginsRelativeArrangement = true
//        overAllStack.layoutMargins = .init(top: 32, left: 8, bottom: 100, right: 8)
        
    }
    
    func getAttributeString(option: Subscription) -> NSMutableAttributedString {
        let text = option.product.localizedTitle.components(separatedBy: " ")
        if text[0].isEmpty || text[1].isEmpty {
            return NSMutableAttributedString(string: "", attributes: nil)
        }
        let attributeString = NSMutableAttributedString(string: text[0] + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 31, weight: UIFont.Weight.heavy)])
        
        attributeString.append(NSAttributedString(string: text[1] + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]))
        attributeString.append(NSAttributedString(string: option.formattedPrice + "\n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)]))
        
        return attributeString
    }
    
    @objc func handleContinue() {
        callback?()
    }
    
}

extension SubscriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Section.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.reuseIdentifier, for: indexPath) as! PromoCollectionViewCell
        let section = Section.allCases[indexPath.item]
        cell.configure(cell: section)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height * (3/5)
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
    }
    
}

