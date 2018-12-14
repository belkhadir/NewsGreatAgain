//
//  NetworkService.swift
//  WeatherApp
//
//  Created by xxx on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//


import Foundation

struct ForHTTPHeaderField {
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
}



enum RequestError: Error {
    case novalidURL(String?)
}

enum HTTPMethod: String{
    case post = "POST"
    case get = "GET"
}

let baseURL = "https://api.darksky.net/forecast/"


func sendGetRequest<T: Decodable>(for type: T.Type,
                           host: String,
                           path: String,
                           port: Int,
                           query: [URLQueryItem],
                           completion: @escaping (Result<T, DataResponseError>) -> Void) {
    
    var compenents = URLComponents()
    compenents.scheme = "http"
    compenents.host = host //"api.coinmarketcap.com"
    compenents.port = port
    compenents.path = path
    compenents.queryItems = query
    
    guard let url = compenents.url else {
        completion(Result.failure(DataResponseError.decoding))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.get.rawValue
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField.ContentType)
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField .Accept)
        
    sendRequest(request, completion, type)
    
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

func convertToDictionary(data: Data) -> [String: Any]? {
    
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print(error.localizedDescription)
    }
    
    return nil
}


func sendPostRequest(bear: String?,
                     host: String,
                     port: Int,
                     path: String
                     ) {
    
}

fileprivate func sendRequest<T: Decodable>(_ request: URLRequest, _ completion: @escaping (Result<T, DataResponseError>) -> Void, _ type: T.Type) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (responseData, response, responseError) in
        guard let jsonD = responseData else {
            completion(Result.failure(DataResponseError.decoding))
            return
        }
        
        do {
            let responseData = try JSONDecoder().decode(type.self, from: jsonD)
            print(responseData)
            completion(Result.success(responseData))
        } catch let error{
            debugPrint(error)
            
            completion(Result.failure(DataResponseError.dataDecodint(data: jsonD)))
        }
    }
    task.resume()
}
