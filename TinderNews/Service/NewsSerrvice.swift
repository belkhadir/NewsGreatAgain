//
//  NewSerrvice.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/9/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class NewService {
    typealias articles = (Result<ResponseData<Article>, DataResponseError>)-> Void
    
    static func getNewsFornext(page: Page.Position,
                        completion: @escaping articles) {
        
        let query = [URLQueryItem(name: "page", value: "\(page.next)")]
        sendRequest(for: ResponseData<Article>.self, host: "newsgreatagain.com", path: EndPath.news, port: 8080, query: query, httpMethod: .get, bear: nil) { completion($0) }
    }
    
    static func addTofavorite(article: Article) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue), let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) {
            
            
        }
    }
    
    static func getFavorite(completion: @escaping articles) {
        
    }
    
}
