//
//  NewsCollectionViewCell.swift
//  TinderNews
//
//  Created by xxx on 11/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit
import SDWebImage
class NewsCollectionViewCell: UICollectionViewCell, Configurable {
    typealias T = Article
    
    func configure(cell with: Article) {
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
        imageView.layer.cornerRadius = 4
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
    
    // Mark: - Initilise
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupLayout() {
        addSubview(imageView)
        setupGradientLayer()
        contentView.layer.cornerRadius = 4
        contentView.backgroundColor = .white
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOffset = CGSize(width: -1, height: 2)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.autoLayout(topAnchor: topAnchor, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor)
        
        addSubview(titleLabel)
        titleLabel.autoLayout(topAnchor: nil, bottomAnchor: bottomAnchor, leadingAnchor: leadingAnchor, trailingAnchor: trailingAnchor, inset: .init(top: 0, left: 16, bottom: 16, right: 0))
    }
    

    
    fileprivate func setupGradientLayer() {
        // how we can draw a gradient with Swift
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        // self.frame is actually zero frame
        
        imageView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = frame
    }
    
    // Mark: - Prepare the cell for reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
