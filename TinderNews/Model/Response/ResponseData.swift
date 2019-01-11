//
//  ResponseData.swift
//  TinderNews
//
//  Created by Belkahdir Anas on 12/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation


class ResponseData<T: Codable>: Codable {
    let data: [T]
    let page: Page
}
