//
//  ArticleView.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class ArticleView: CardView, Configurable {
    typealias T = Article
    fileprivate var article: Article?
    func configure(cell with: Article) {
        article = with
        titleLabel.text = with.title
        guard let urlContent = with.url else {
            return
        }
        linkButton.setTitle(urlContent, for: .normal)
        
        guard let urlString = with.urlToImage else {
            return
        }
        let url = URL(string: urlString)
        let placeHolder = UIImage(named: "placeHolder")
        imageView.sd_setImage(with: url, placeholderImage: placeHolder, options: .retryFailed, completed: nil)

        
        
        titleLabel.sizeToFit()
    }
    
    weak var linkDelegate: LinkDelegate?
    
    // Mark: - Propeties
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    let linkButton = UIButton()
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    
    override func setupLayout() {
        super.setupLayout()
        addTarget()
        addSubview(imageView)
        setupGradientLayer()
        imageView.layer.cornerRadius = cornerRadius
        imageView.fillSuperView()
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.setTitle("LINK", for: .normal)
        addSubview(titleLabel)
        addSubview(linkButton)
        titleLabel.autoLayout(topAnchor: nil, bottomAnchor: nil, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, inset: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        linkButton.autoLayout(topAnchor: titleLabel.bottomAnchor, bottomAnchor: bottomAnchor, leadingAnchor: titleLabel.leadingAnchor, trailingAnchor: trailingAnchor, inset: .init(top: 8, left: 0, bottom: 16, right: 8))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = imageView.frame //CGRect(x: 0, y: frame.maxY, width: frame.width, height: frame.height)
    }
    
    fileprivate func addTarget() {
        linkButton.addTarget(self, action: #selector(handleLinkButton), for: .touchUpInside)
    }
    
    @objc func handleLinkButton() {
        guard let article = article else { return }
        linkDelegate?.didTapLink(cardView: self, artilce: article)
    }
    
    fileprivate func setupGradientLayer() {
        // how we can draw a gradient with Swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        // self.frame is actually zero frame
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func handleTap(gesture: UITapGestureRecognizer) {
        super.handleTap(gesture: gesture)
        guard let article = article else { return }
        delegate?.didTapMoreInfo(cardView: self, artilce: article)
    }
    
    
}
