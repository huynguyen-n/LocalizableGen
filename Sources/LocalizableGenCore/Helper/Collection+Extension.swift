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

    public func build() -> SheetValues {
        let dict = self as! [String: String]
        return [ [String](dict.keys), [String](dict.values) ]
    }

    public func withUniqeValue() -> SheetValues {
        let dict = self as! [String: String]

        var unique = Set<[String: String]>()
        var duplicate = Set<[String: String]>()
        var setValue = Set<String>()

        for (key, value) in dict {
            let member = [key: value]
            if setValue.contains(value) {
                duplicate.insert(member)
            } else {
                setValue.insert(value)
                unique.insert(member)
            }
        }

        return [ unique.commaJoinedKeys(), unique.commaJoinedValues() ]
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

extension Set where Element == Dictionary<String, String> {
    func commaJoinedKeys() -> [String] {
        return self.compactMap { $0.keys.joined() }
    }

    func commaJoinedValues() -> [String] {
        return self.compactMap { $0.values.joined() }
    }
}
