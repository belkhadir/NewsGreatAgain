//
//  ArticleView.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class ArticleView: CardView, Configurable {
    typealias T = Article
    fileprivate var article: Article?
    func configure(cell with: Article) {
        article = with
        titleLabel.text = with.title
        guard let urlString = with.urlToImage else {
            return
        }
        let url = URL(string: urlString)
        imageView.sd_setImage(with: url, completed: nil)
        titleLabel.sizeToFit()
    }
    
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
    
    fileprivate let gradientLayer = CAGradientLayer()
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(imageView)
        setupGradientLayer()
        imageView.layer.cornerRadius = cornerRadius
        imageView.fillSuperView()
        
        addSubview(titleLabel)
        titleLabel.autoLayout(topAnchor: nil, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, inset: .init(top: 0, left: 16, bottom: 16, right: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = imageView.frame //CGRect(x: 0, y: frame.maxY, width: frame.width, height: frame.height)
    }
    
    fileprivate func setupGradientLayer() {
        // how we can draw a gradient with Swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        // self.frame is actually zero frame
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
