//
//  Spreadsheet.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

public struct Spreadsheet: Decodable {
    public private(set) var spreadsheetId: String
    public private(set) var valueRanges: [Sheet]
}
