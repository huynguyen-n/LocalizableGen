//
//  LocalizableConfigFile.swift
//  
//
//  Created by Huy Nguyen on 21/04/2022.
//

import Foundation

public struct LocalizableConfigFile: Decodable {
    internal init(googleSheetID: String, primaryGoogleSheetName: String, platform: String) {
        self.googleSheetID = googleSheetID
        self.primaryGoogleSheetName = primaryGoogleSheetName
        self.platform = platform
    }

    public private(set) var googleSheetID: String
    public private(set) var primaryGoogleSheetName: String
    public private(set) var platform: String

    enum CodingKeys: CodingKey {
        case google_sheet_id
        case primary_google_sheet_name
        case platform
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.googleSheetID = try container.decode(String.self, forKey: .google_sheet_id)
        self.primaryGoogleSheetName = try container.decode(String.self, forKey: .primary_google_sheet_name)
        self.platform = try container.decode(String.self, forKey: .platform)
    }
}
