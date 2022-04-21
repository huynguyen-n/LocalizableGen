//
//  Collection+Extension.swift
//  
//
//  Created by Huy Nguyen on 20/04/2022.
//

import Foundation

extension Dictionary {
    public init(keys: [Key], values: [Value]) {
        precondition(keys.count == values.count)

        self.init()

        for (index, key) in keys.enumerated() {
            self[key] = values[index]
        }
    }
}

extension Collection {
    func first() -> Element {
        guard let first = self.first else {
            fatalError() // or maybe return any kind of default value?
        }
        return first
    }
}
