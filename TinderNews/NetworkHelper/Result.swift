//
//  Result.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
