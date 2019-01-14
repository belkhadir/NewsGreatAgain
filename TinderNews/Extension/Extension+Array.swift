//
//  Extension+Array.swift
//  TinderNews
//
//  Created by Belkhadir Anas on 1/2/19.
//  Copyright © 2019 Belkhadir. All rights reserved.
//

import Foundation

extension Array {
    
    func filterDuplicates(_ includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        
        return results
    }
    
}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
