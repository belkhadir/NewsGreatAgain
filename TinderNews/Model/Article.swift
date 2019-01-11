//
//  Article.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


struct Article: Codable {
    var id: Int? = nil
    var author: String? = nil
    var title: String? = nil
    var description: String? = nil
    var url: String? = nil
    var urlToImage: String? = nil
    var publishedAt: String? = nil
    var content: String? = nil
    
    init(article: Favorite) {
        author = article.author
        title = article.title
        description = article.descriptions
        url = article.url
        urlToImage = article.urlToImage
        publishedAt = article.publishedAt
        content = article.content
        
    }
}

extension Article: Equatable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Article: Hashable {
    var hashValue: Int {
        return id!
    }
}
