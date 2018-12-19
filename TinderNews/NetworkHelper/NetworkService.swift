//
//  NetworkService.swift
//  WeatherApp
//
//  Created by xxx on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//


import Foundation

enum ForHTTPHeaderField: String {
    case accept = "Accept"
    case contentType = "Content-Type"
    case authorization = "Authorization"
}



enum RequestError: Error {
    case novalidURL(String?)
}

enum HTTPMethod: String{
    case post = "POST"
    case get = "GET"
}

let baseURL = "https://api.darksky.net/forecast/"

func sendRequest<T: Decodable>(for type: T.Type,
                                  host: String,
                                  path: EndPath,
                                  port: Int,
                                  query: [URLQueryItem],
                                  httpMethod: HTTPMethod,
                                  bear: String? = nil,
                                  json: [String: Any]? = nil,
                                  completion: @escaping (Result<T, DataResponseError>) -> Void) {
    
    var compenents = URLComponents()
    compenents.scheme = "http"
    compenents.host = host //"api.coinmarketcap.com"
    compenents.path = "/" + path.rawValue
    compenents.queryItems = query
    
    guard let url = compenents.url else {
        completion(Result.failure(DataResponseError.decoding))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = httpMethod.rawValue
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField.contentType.rawValue)
    request.addValue("application/json", forHTTPHeaderField: ForHTTPHeaderField.accept.rawValue)
    
    if let json = json {
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
    }
    
    if let userToken = bear {
        let tokenString = "Bearer " + userToken
        request.addValue(tokenString, forHTTPHeaderField: ForHTTPHeaderField.authorization.rawValue)
    }
    sendRequest(request, completion, type)
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
//            print(responseData)
            completion(Result.success(responseData))
        } catch let error{
            debugPrint(error)
            
            completion(Result.failure(DataResponseError.dataDecodint(data: jsonD)))
        }
    }
    task.resume()
}
