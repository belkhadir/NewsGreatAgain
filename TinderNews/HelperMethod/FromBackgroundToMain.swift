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
