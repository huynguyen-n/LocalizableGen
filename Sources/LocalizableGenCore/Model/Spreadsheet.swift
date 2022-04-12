//
//  Spreadsheet.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

public struct Spreadsheet: Codable {
    public private(set) var spreadsheetId: String
    public private(set) var valueRanges: [Sheet]
}

extension Collection {
    func first() -> Element {
        guard let first = self.first else {
            fatalError() // or maybe return any kind of default value?
        }
        return first
    }
}
