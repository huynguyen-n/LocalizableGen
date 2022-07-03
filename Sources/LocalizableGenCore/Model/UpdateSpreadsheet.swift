//
//  UpdateSpreadsheet.swift
//  
//
//  Created by Huy Nguyen on 11/05/2022.
//

import Foundation

public struct UpdateSpreadsheet: Decodable {
    public private(set) var totalUpdatedRows: Int
    public private(set) var spreadsheetId: String
    public private(set) var totalUpdatedColumns: Int
    public private(set) var totalUpdatedSheets: Int
    public private(set) var totalUpdatedCells: Int
}
