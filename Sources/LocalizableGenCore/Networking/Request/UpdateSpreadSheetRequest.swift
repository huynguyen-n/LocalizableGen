//
//  UpdateSpreadSheetRequest.swift
//  
//
//  Created by Huy Nguyen on 13/04/2022.
//

import Foundation

public struct UpdateSpreadSheetParam: Parameter {
    public init(spreadSheetId: String, valueInputOption: UpdateSpreadSheetParam.ValueInputOption, data: [Sheet]) {
        self.spreadSheetId = spreadSheetId
        self.valueInputOption = valueInputOption
        self.data = data
    }

    public enum ValueInputOption {
        case inputValueOptionUnspecified
        case raw
        case userEntered

        var value: String {
            switch self {
            case .inputValueOptionUnspecified:
                return "INPUT_VALUE_OPTION_UNSPECIFIED"
            case .raw:
                return "RAW"
            case .userEntered:
                return "USER_ENTERED"
            }
        }
    }

    public private(set) var spreadSheetId: String
    public private(set) var valueInputOption: ValueInputOption
    public private(set) var data: [Sheet]

    public func toDictionary() -> [String : Any] {
        var params: [String: Any] = ["valueInputOption": self.valueInputOption.value]
        if let sheet = self.data.first {
            params["data"] = [
                [
                    "range": sheet.range.value,
                    "values": sheet.values,
                    "majorDimension": sheet.majorDimension.value
                ]
            ]
        }
        return params
    }
}

final class UpdateSpreadSheetRequest: Request {

    typealias Element = UpdateSpreadsheet

    var endpoint: String {
        return Constant.APIEndPoint.SpreadSheet + "/\(self._param.spreadSheetId)/values:batchUpdate"
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var param: Parameter? {
        return self._param
    }

    func decode(data: Data) -> UpdateSpreadsheet? {
        do {
            let result = try JSONDecoder().decode(Element.self, from: data)

            return result

        } catch { return nil }
    }

    public private(set) var _param: UpdateSpreadSheetParam

    init(_ param: UpdateSpreadSheetParam) {
        self._param = param
    }
}
