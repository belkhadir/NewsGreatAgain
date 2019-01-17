//
//  HomeCollectionViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/20/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import GoogleMobileAds
import JGProgressHUD

class HomeCollectionViewCell: UICollectionViewCell {
    
    fileprivate let cardsView = UIView()
    fileprivate let homebottomStack = HomebottomStackView()
    
    fileprivate var articles = [Article]() {
        didSet {
            if articles.isEmpty {
                fetchmoreNews()
            }
        }
    }
    
    fileprivate var page = Page.Position(current: 1,max: 0, next: 1, previous: 1)
    
    fileprivate let loadingView = JGProgressHUD(style: JGProgressHUDStyle.light)
    
    fileprivate var topCard: CardView?
    
    weak var rootController: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        fetchmoreNews()
        addTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addNewsTocard() {
        var previousCardView: CardView?
        topCard = nil
        
        
        
//        articles.forEach { (article) in
//            let cardView: ArticleView = ArticleView(frame: .zero)
//            cardView.configure(cell: article)
//            self.cardsView.addSubview(cardView)
//            self.cardsView.sendSubviewToBack(cardView)
//
//            cardView.fillSuperView()
//            cardView.delegate = self
//            previousCardView?.nextCardView = cardView
//            previousCardView = cardView
//
//            if topCard == nil {
//                topCard = cardView
//            }
//        }
        
        for (index, article) in articles.enumerated() {
            let cardView: ArticleView = ArticleView(frame: .zero)
            cardView.configure(cell: article)
            self.cardsView.addSubview(cardView)
            self.cardsView.sendSubviewToBack(cardView)
            
            cardView.fillSuperView()
            cardView.delegate = self
            previousCardView?.nextCardView = cardView
            previousCardView = cardView
            
            if topCard == nil {
                topCard = cardView
            }
            
            if index == 9 {
                if !isFreeFromAds {
                    let ads = AdsView(frame: .zero)
                    ads.viewController = rootController
                    cardsView.addSubview(ads)
                    self.cardsView.sendSubviewToBack(ads)
                    ads.fillSuperView()
                    ads.loadRequest()
                }
            }
        }
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        
        let overAllStackView = UIStackView(arrangedSubviews: [cardsView, homebottomStack])
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        overAllStackView.axis = .vertical
        
        addSubview(overAllStackView)
        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overAllStackView.bringSubviewToFront(cardsView)
    }
    
    func fetchmoreNews() {
        if !isUnlocked {
            if  page.current == 4{
                // TODO: Tell the user if he want more news he need to subscribe
                return
            }
        }
        
        loadingView.show(in: self)
        if page.max == page.current {
            call {
                self.loadingView.dismiss()
            }
            return
        }
        NewsService.getNewsFornext(page: page) { [weak self](result) in
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                let data = success.data.filter {
                    return !($0.urlToImage == nil && $0.title == nil)
                }
                weakSelf.articles.append(contentsOf: data)
                weakSelf.page = success.page.position
                DispatchQueue.main.async {
                    weakSelf.loadingView.dismiss()
                    weakSelf.addNewsTocard()
                }
            }
        }
    }
    
    fileprivate func addTarget() {
        homebottomStack.likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        homebottomStack.dislikeButton.addTarget(self, action: #selector(handleDisLike), for: .touchUpInside)
    }
    
    @objc func handleLike() {
        if let first = articles.first {
            NewsService.addTofavorite(favorite: true, article: first)
            animateTheremoveCard(left: false)
        }
    }
    
    @objc func handleDisLike() {
        if let first = articles.first {
            NewsService.addTofavorite(favorite: false, article: first)
            animateTheremoveCard(left: true)
        }
    }

    
    func animateTheremoveCard(left: Bool) {
        let translateAnimation = CABasicAnimation(keyPath: "position.x")
        translateAnimation.toValue = left ? -700:700
        translateAnimation.duration = 0.5
        translateAnimation.fillMode =  .forwards
        translateAnimation.isRemovedOnCompletion = false
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 15 * CGFloat.pi / 180
        rotationAnimation.duration = 0.5
        
        let cardView = topCard
        topCard = cardView?.nextCardView
        
        CATransaction.setCompletionBlock {
            cardView?.removeFromSuperview()
            if !self.articles.isEmpty {
                self.articles.removeLast()
            }
        }
        
        cardView?.layer.add(translateAnimation, forKey: "translation")
        cardView?.layer.add(rotationAnimation, forKey: "rotation")
        
        CATransaction.commit()
        
    }
    
}

extension HomeCollectionViewCell: CardViewDelegate {
    func didDislike(_ cell: CardView) {
        if let first = articles.first {
            NewsService.addTofavorite(favorite: false, article: first)
        }
    }
    
    func didLike(_ cell: CardView) {
        if let first = articles.first {
            let _ = Favorite(article: first, insertInto: CoreDataStackManager.shared.managedObjectContext)
            CoreDataStackManager.shared.saveContext()
            NewsService.addTofavorite(favorite: true, article: first)
        }
    }
    
    func didTapMoreInfo(cardView: CardView, artilce: Article) {
        let detail = DetailsViewController()
        detail.article = artilce
        rootController?.present(detail, animated: true, completion: nil)
    }
    
    func didRemoveCardView(cardView: CardView) {
        topCard?.removeFromSuperview()
        topCard = topCard?.nextCardView
        if !articles.isEmpty {
            articles.removeLast()
        }
        
        StoreReviewHelper.checkAndAskForReview()
        
        
    }
    
}
