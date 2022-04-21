//
//  Sheet.swift
//  
//
//  Created by Huy Nguyen on 07/04/2022.
//

import Foundation

public typealias SheetValues = [[String]]

public struct Sheet: Decodable {
    public private(set) var range: Range
    public private(set) var majorDimension: Dimension
    public private(set) var values: SheetValues

    public init(range: Range, majorDimension: Dimension, values: SheetValues) {
        self.range = range
        self.majorDimension = majorDimension
        self.values = values
    }

    public init(range: Range, majorDimension: Dimension) {
        self.range = range
        self.majorDimension = majorDimension
        self.values = []
    }

    enum CodingKeys : String, CodingKey {
        case range
        case majorDimension
        case values
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        values = try container.decode(SheetValues.self, forKey: .values)
        let majorDimensionString = try container.decode(String.self, forKey: .majorDimension)
        majorDimension = Dimension(value: majorDimensionString) ?? .dimensionUnspecified
        let rangeString = try container.decode(String.self, forKey: .range)
        range = Range(stringValue: rangeString)
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

    var language: String {
        let lang = self.last?.first?.components(separatedBy: " - ")
        return String(lang?.last ?? "")
    }
}
