//
//  FromBackgroundToMain.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

func call(from background: @escaping () ->Void ) {
    DispatchQueue.main.async {
        background()
    }
}

func convertToDictionary(data: Data) -> [String: Any]? {
    
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print(error.localizedDescription)
    }
    
    return nil
}


func convertToArticles() -> ResponseData<Article>? {
    if let path = Bundle.main.path(forResource: "file", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            do {
                let responseData = try JSONDecoder().decode(ResponseData<Article>.self, from: data)
                return responseData
                
            } catch let error{
                debugPrint(error)
                return nil
            }
        }catch let error {
            print(error.localizedDescription)
        }
    }
    return nil
}
