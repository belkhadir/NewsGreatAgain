//
//  Identifiable.swift
//  WeatherApp
//
//  Created by Belkhadir Anas on 11/2/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import UIKit

protocol Identifiable {}


extension Identifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UICollectionReusableView: Identifiable {}
extension UITableViewCell: Identifiable {}
extension UICollectionViewCell: Identifiable {}
