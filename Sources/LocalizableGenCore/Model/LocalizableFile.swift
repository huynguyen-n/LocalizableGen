//
//  LocalizableFile.swift
//  
//
//  Created by Huy Nguyen on 11/04/2022.
//

import Foundation

public typealias CSVDictionaryFormat = Dictionary<String, String>

public struct LocalizableFile {
    public init(module: String, language: String, data: CSVDictionaryFormat) {
        self.module = module
        self.language = language
        self.data = data
    }

    public private(set) var module: String
    public private(set) var language: String
    public private(set) var data: CSVDictionaryFormat
}
