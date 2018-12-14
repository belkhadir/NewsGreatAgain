//
//  Article.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 11/18/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


struct Article: Codable {
    var author: String?
    let title: String?
    let description: String?
    let url: String?
    var urlToImage: String?
    let publishedAt: String?
    var content: String?
}

