//
//  LoginDelegate.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/13/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation



protocol LoginDelegate {
    func didStart()
    func didLoginIn(user: User, token: String)
    func didFailToLoginIn(error: Error)
}
