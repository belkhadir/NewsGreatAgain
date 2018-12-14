//
//  NewSerrvice.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/9/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class NewService {
    
    static func getNewsFornext(page: Page.Position,
                        completion: @escaping (Result<ResponseData<Article>, DataResponseError>)-> Void) {
        
        let query = [URLQueryItem(name: "page", value: "\(page.next)")]
        sendRequest(for: ResponseData<Article>.self, host: "localhost", path: EndPath.news, port: 8080, query: query, httpMethod: .get, bear: nil) { completion($0) }
    }
    
}
