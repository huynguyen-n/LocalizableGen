//
//  Range.swift
//  
//
//  Created by Huy Nguyen on 20/04/2022.
//

import Foundation


public struct Range {

    private let EXCLAMATION_MARK: Character = "!"
    private let COLON: Character = ":"

    public init(sheetName: String, cells: RangeCell<String, String>) {
        self.sheetName = sheetName
        self.cells = cells
    }

    public private(set) var sheetName: String
    public private(set) var cells: RangeCell<String, String>

    var value: String {
        return "\(sheetName)\(EXCLAMATION_MARK)\(cells.column)\(COLON)\(cells.row ?? "Z")"
    }

    public init(stringValue: String) {
        let strings = stringValue.split(separator: EXCLAMATION_MARK)
        self.sheetName = String(strings.first())
        guard let cells = strings.last?.split(separator: COLON),
              let column = cells.first else {
                  self.cells = RangeCell(column: "", row: nil)
                  return
              }
        self.cells = RangeCell(column: String(column), row: String(cells.last ?? "Z"))
    }
}
