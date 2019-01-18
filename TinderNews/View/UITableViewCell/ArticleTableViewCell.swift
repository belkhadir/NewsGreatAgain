//
//  ArticleTableViewCell.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/21/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell, Configurable {
    typealias T = Article
    
    fileprivate var article: Article?
    
    
    fileprivate let newsImageView = UIImageView()
    fileprivate let titleLabel = UILabel()
    
    func configure(cell with: Article) {
        self.article = with
        guard let urlstring = with.urlToImage, let title = with.title else { return }
        let url = URL(string: urlstring)
        newsImageView.sd_setImage(with: url, completed: nil)
        titleLabel.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21), NSAttributedString.Key.foregroundColor: UIColor.black])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        addSubview(newsImageView)
        addSubview(titleLabel)
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        
        newsImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        newsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: newsImageView.bottomAnchor).isActive = true
        
        newsImageView.layer.cornerRadius = 5
        newsImageView.clipsToBounds = true
        
//        let overAllStack = UIStackView(arrangedSubviews: [newsImageView, titleLabel])
//        overAllStack.alignment = .center
//        overAllStack.distribution = .fill
//        overAllStack.axis = .horizontal
//        overAllStack.spacing = 8
//        overAllStack.fillSuperView()
//
//        overAllStack.isBaselineRelativeArrangement = true
//        overAllStack.layoutMargins = .init(top: 16, left: 16, bottom: 16, right: 16)
//        addSubview(overAllStack)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        titleLabel.text = nil
    }
}
