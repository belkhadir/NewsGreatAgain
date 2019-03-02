//
//  NewsViewController.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewsViewController: UIViewController {
    fileprivate let navigationStack = NavigationStackView()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        articles = [Article]()
        addTarget()
    }
    
    fileprivate func addNewsTocard() {
        var previousCardView: CardView?
        topCard = nil

        articles.forEach { (article) in
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
        }

        let ads = AdsView(frame: .zero)
        ads.viewController = self
        cardsView.addSubview(ads)
        self.cardsView.sendSubviewToBack(ads)
        ads.fillSuperView()
        ads.loadRequest()
        
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white

        let overAllStackView = UIStackView(arrangedSubviews: [navigationStack, cardsView, homebottomStack])
        overAllStackView.translatesAutoresizingMaskIntoConstraints = false
        overAllStackView.axis = .vertical
        
        view.addSubview(overAllStackView)
        overAllStackView.fillSuperView()
        overAllStackView.isLayoutMarginsRelativeArrangement = true
        overAllStackView.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        
        overAllStackView.bringSubviewToFront(cardsView)
    }

    func fetchmoreNews() {
        loadingView.show(in: view)
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
        navigationStack.favoriteButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        navigationStack.logoButton.addTarget(self, action: #selector(handleLogo), for: .touchUpInside)
//        navigationStack.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        homebottomStack.likeButton.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        homebottomStack.dislikeButton.addTarget(self, action: #selector(handleDisLike), for: .touchUpInside)
    }
    
    @objc func handleLike() {
        animateTheremoveCard(left: false)
    }
    
    @objc func handleDisLike() {
        animateTheremoveCard(left: true)
    }

    @objc func handleFavorite() {
        tranlateStack(with: -10)
    }
    @objc func handleLogo() {
        tranlateStack(with: view.frame.width / 2)
    }
    
    @objc func handleSettings() {
        
//        tranlateStack(with: 350)
    }
    
    func tranlateStack(with value: CGFloat) {
        let translateAnimation = CABasicAnimation(keyPath: "position.x")
        translateAnimation.toValue = value
        translateAnimation.duration = 0.5
        translateAnimation.fillMode =  .forwards
        translateAnimation.isRemovedOnCompletion = false
        translateAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        navigationStack.layer.add(translateAnimation, forKey: "tranlation")
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

extension NewsViewController: CardViewDelegate {
    func didDislike(_ cell: CardView) {
        
    }
    
    func didLike(_ cell: CardView) {
        
    }
    
    func didTapMoreInfo(cardView: CardView, artilce: Article) {
        let detail = DetailsViewController()
        detail.article = artilce
        present(detail, animated: true, completion: nil)
    }
    
    func didRemoveCardView(cardView: CardView) {
        self.topCard?.removeFromSuperview()
        self.topCard = self.topCard?.nextCardView
        if !articles.isEmpty {
            self.articles.removeLast()
        }
    }
}
