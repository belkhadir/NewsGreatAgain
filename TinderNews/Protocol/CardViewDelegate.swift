//
//  CardViewDelegate.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 12/19/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

protocol CardViewDelegate: class {
    func didTapMoreInfo(cardView: CardView, artilce: Article)
    func didRemoveCardView(cardView: CardView)
    func didDislike(_ cell: CardView)
    func didLike(_ cell: CardView)
}
