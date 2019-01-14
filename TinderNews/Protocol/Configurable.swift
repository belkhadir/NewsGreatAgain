//
//  Configurable.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype T
    func configure(cell with: T)
}


