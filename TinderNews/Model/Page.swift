//
//  Page.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


struct Page: Codable {
    let position: Position
    let data: DataPage
    
    
    struct Position: Codable {
        let current: Int
        let max: Int
        let next: Int
        let previous: Int?
    }
    
    struct DataPage: Codable {
        let per: Int
        let total: Int
    }
}
