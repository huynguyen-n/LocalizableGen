//
//  LocalizableConfigFile.swift
//  
//
//  Created by Huy Nguyen on 21/04/2022.
//

import Foundation

public struct LocalizableConfigFile: Decodable {
    internal init(googleSheetID: String, primaryGoogleSheetName: String, platform: String, stringResourceFolderPath: String) {
        self.googleSheetID = googleSheetID
        self.primaryGoogleSheetName = primaryGoogleSheetName
        self.platform = platform
        self.stringResourceFolderPath = stringResourceFolderPath
    }

    public private(set) var googleSheetID: String
    public private(set) var primaryGoogleSheetName: String
    public private(set) var platform: String
    public private(set) var stringResourceFolderPath: String


    enum CodingKeys: CodingKey {
        case google_sheet_id
        case primary_google_sheet_name
        case platform
        case string_resources_folder_path
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.googleSheetID = try container.decode(String.self, forKey: .google_sheet_id)
        self.primaryGoogleSheetName = try container.decode(String.self, forKey: .primary_google_sheet_name)
        self.platform = try container.decode(String.self, forKey: .platform)
        self.stringResourceFolderPath = try container.decode(String.self, forKey: .string_resources_folder_path)
    }
}

protocol LocalizableConfigFilePr {
    var path: String { get }
    func file() throws -> LocalizableConfigFile
}

extension LocalizableConfigFilePr {
    func file() throws -> LocalizableConfigFile {
        do {
            let file = try File(path: path)
            return try file.decode(of: LocalizableConfigFile.self)
        } catch {
            throw error
        }
    }
}
