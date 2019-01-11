//
//  NewSerrvice.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/9/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class NewsService {
    typealias articles = (Result<ResponseData<Article>, DataResponseError>)-> Void
    
    static func getNewsFornext(page: Page.Position,
                        completion: @escaping articles) {
        
        let query = [URLQueryItem(name: "page", value: "\(page.next)")]
        sendRequest(for: ResponseData<Article>.self, host: EndURL.host.rawValue, path: EndPath.news, port: 8080, query: query, httpMethod: .get, bear: nil) { completion($0) }
    }
    
    static func addTofavorite(favorite: Bool, article: Article) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue), let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue), let id = article.id {
            let subPath = favorite ? EndPath.addfavorite.rawValue: EndPath.unfavorite.rawValue
            let path = "\(userID)/" +  subPath + "/\(id)"
            sendRequest(for: HTTPStatus.self, host: EndURL.host.rawValue, stringPath: path, port: 8080, query: [], httpMethod: HTTPMethod.post, bear: token) { (result) in
                print(result)
            }
        }
    }
    
    static func getFavorite(page: Page.Position, completion: @escaping articles) {
        if let token = UserDefaults.standard.string(forKey: UserDefaultKey.token.rawValue), let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) {
            let query = [URLQueryItem(name: "page", value: "\(page.next)")]
            let path = "\(userID)/" + EndPath.favorite.rawValue
            sendRequest(for: ResponseData<Article>.self, host: EndURL.host.rawValue, stringPath: path, port: 8080, query: query, httpMethod: HTTPMethod.get, bear: token) { (result) in
                completion(result)
            }
            
        }
        
    }
    
}
