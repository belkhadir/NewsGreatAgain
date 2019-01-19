//
//  DataResponceError.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//


import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    case dataDecodint(data: Data)
    case response
    case missingAccountSecret
    case invalidSession
    case noActiveSubscription
    case other(Error)
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        case .dataDecodint:
            return "DAATA"
        case .response:
            return "Comand invalid please contact the support"
        default: return ""
        }
    }
}
