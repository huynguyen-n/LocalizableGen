//
//  SpreadSheet.swift
//  
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

struct SpreadSheetRequest: Request {
    public private(set) var spreadSheetId: String
    public private(set) var sheetName: String

    init(spreadSheetId: String, sheetName: String = "") {
        self.spreadSheetId = spreadSheetId
        self.sheetName = sheetName
    }

    func decode(data: Data) -> Spreadsheet? {
        do {
            let result = try JSONDecoder().decode(CodableResponse.self, from: data)

            return result

        } catch { return nil }
    }

    typealias CodableResponse = Spreadsheet

    var param: Parameters? {
        return nil
    }

    var queryItems: [URLQueryItem]? {
        return [
            URLQueryItem(name: "access_token", value: GoogleOAuth.share.accessToken),
            URLQueryItem(name: "ranges", value: "\(sheetName.isEmpty ? "" : sheetName + "!")A1:Z"),
            URLQueryItem(name: "majorDimension", value: "COLUMNS")
        ]
    }

    var endpoint: String {
        return Constant.APIEndPoint.SpreadSheet + "/\(spreadSheetId)/values:batchGet"
    }

    var httpMethod: HTTPMethod {
        return .get
    }
}
