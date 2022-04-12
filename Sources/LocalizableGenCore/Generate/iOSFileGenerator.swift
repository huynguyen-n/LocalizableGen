//
//  iOSFileGenerator.swift
//  
//
//  Created by Huy Nguyen on 11/04/2022.
//

import Foundation

struct iOSFileGenerator: FileGenerator {
    var localizableFile: LocalizableFile

    init(localizableFile: LocalizableFile) {
        self.localizableFile = localizableFile
    }

    var platform: Platform {
        return .iOS
    }
}
