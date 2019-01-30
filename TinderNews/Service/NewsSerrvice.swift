//
//  NewSerrvice.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/9/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

let itcAccountSecret = "42ef7af5cef24423842ebe72cc23781f"

class NewsService {
    typealias articles = (Result<ResponseData<Article>, DataResponseError>)-> Void
    
    public static let shared = NewsService()
    let simulatedStartDate: Date
    
    private var sessions = [SessionId: Session]()
    
    init() {
        let persistedDateKey = "StartDate"
        if let persistedDate = UserDefaults.standard.object(forKey: persistedDateKey) as? Date {
            simulatedStartDate = persistedDate
        } else {
            let date = Date().addingTimeInterval(-30) // 30 second difference to account for server/client drift.
            UserDefaults.standard.set(date, forKey: "StartDate")
            
            simulatedStartDate = date
        }
    }
    
    
    static func getNewsFornext(page: Page.Position,
                        completion: @escaping articles) {
        
        let query = [URLQueryItem(name: "page", value: "\(page.next)"),
                     URLQueryItem(name: "per", value: "15")]
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
    
    
    /// Trade receipt for session id
    public func upload(receipt data: Data, completion: @escaping (_ result: Result<(sessionId: String, currentSubscription: PaidSubscription?), DataResponseError>) -> Void ) {
        let body = [
            "receipt-data": data.base64EncodedString(),
            "password": itcAccountSecret
        ]
        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        let task = URLSession.shared.dataTask(with: request) { (responseData, response, error) in
            if let error = error {
                completion(.failure(.other(error)))
            } else if let responseData = responseData {
                let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as! Dictionary<String, Any>
                print(json)
                let session = Session(receiptData: data, parsedReceipt: json)
                self.sessions[session.id] = session
                let result = (sessionId: session.id, currentSubscription: session.currentSubscription)
                completion(.success(result))
            }
        }
        
        task.resume()
    }
    
    
    /// Use sessionId to get selfies
//    public func getNews(page: Page.Position, for sessionId: SessionId,  completion: @escaping articles) {
//        
//        
//        
//        guard let _ = sessions[sessionId] else {
//            if TrackPageHelper.count <= 60 {
//                NewsService.getNewsFornext(page: page) { completion($0) }
//            }else {
//                completion(.failure(.noActiveSubscription))
//            }
//            return
//        }
//
//        let paidSubscriptions = paidSubcriptions(since: simulatedStartDate, for: sessionId)
//        
//        if paidSubscriptions.count > 0 {
//            var article = false
//            for subscription in paidSubscriptions {
//                switch subscription.level {
//                case .none:
//                    completion(.failure(.noActiveSubscription))
//                default:
//                    article = true
//                    break
//                    
//                }
//            }
//            
//            if article {
//                
//                NewsService.getNewsFornext(page: page) { completion($0) }
//            }
//        }else {
//            completion(.failure(.noActiveSubscription))
//        }
//    }
    
    
    private func paidSubcriptions(since date: Date, for sessionId: SessionId) -> [PaidSubscription] {
        if let session = sessions[sessionId] {
            let subscriptions = session.paidSubscriptions.filter { $0.purchaseDate >= date }
            return subscriptions.sorted { $0.purchaseDate < $1.purchaseDate }
        } else {
            return []
        }
    }
}
