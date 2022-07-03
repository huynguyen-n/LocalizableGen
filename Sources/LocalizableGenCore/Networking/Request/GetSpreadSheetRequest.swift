//
//  SpreadSheet.swift
//  
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

public struct GetSpreadSheetRequestQueryItem: QueryItem {
    public init(spreadSheetId: String, sheet: Sheet) {
        self.spreadSheetId = spreadSheetId
        self.sheet = sheet
    }

    public private(set) var spreadSheetId: String
    public private(set) var sheet: Sheet

    public func toArray() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "ranges", value: sheet.range.value),
            URLQueryItem(name: "majorDimension", value: sheet.majorDimension.value)
        ]
    }
}

final class GetSpreadSheetRequest: Request {

    public private(set) var _queryItem: GetSpreadSheetRequestQueryItem

    init(queryItem: GetSpreadSheetRequestQueryItem) {
        self._queryItem = queryItem
    }

    func decode(data: Data) -> Spreadsheet? {
        do {
            let result = try JSONDecoder().decode(Element.self, from: data)

            return result

        } catch { return nil }
    }

    typealias Element = Spreadsheet

    var queryItem: QueryItem? {
        return self._queryItem
    }

    var endpoint: String {
        return Constant.APIEndPoint.SpreadSheet + "/\(_queryItem.spreadSheetId)/values:batchGet"
    }

    var httpMethod: HTTPMethod {
        return .get
    }
}
