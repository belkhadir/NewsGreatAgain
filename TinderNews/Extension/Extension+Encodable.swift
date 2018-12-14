//
//  Extension+Encodable.swift
//  TinderNews
//
//  Created by xxx on 12/14/18.
//  Copyright © 2018 Belkhadir. All rights reserved.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)).flatMap { $0 as? [String: Any] }
    }
}
