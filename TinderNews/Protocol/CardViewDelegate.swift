//
//  CardViewDelegate.swift
//  TinderNews
//
//  Created by xxx on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

protocol CardViewDelegate: class {
    func didTapMoreInfo()
    func didRemoveCardView(cardView: CardView)
}
