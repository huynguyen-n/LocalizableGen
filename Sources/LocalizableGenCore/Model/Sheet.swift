//
//  Sheet.swift
//  
//
//  Created by Huy Nguyen on 07/04/2022.
//

import Foundation

public typealias SheetValues = [[String]]

public struct Sheet: Codable {
    public private(set) var range: String
    public private(set) var majorDimension: String
    public private(set) var values: SheetValues

    public init(range: String, majorDimension: String, values: SheetValues) {
        self.range = range
        self.majorDimension = majorDimension
        self.values = values
    }
}

extension SheetValues {

    var keys: [String] {
        guard let first = self.first else {
            preconditionFailure()
        }
        var _first = first
        _first.removeFirst() // as the 'key' value
        return _first
    }

    func toDictionary(with index: Int) -> CSVDictionaryFormat {
        guard index > 0 else {
            preconditionFailure()
        }
        var languages = self[index]
        languages.removeFirst() // as key of language: like en or vn...
        return Dictionary(keys: self.keys, values: languages)
    }
}

extension Dictionary {
    public init(keys: [Key], values: [Value]) {
        precondition(keys.count == values.count)

        self.init()

        for (index, key) in keys.enumerated() {
            self[key] = values[index]
        }
    }
}
