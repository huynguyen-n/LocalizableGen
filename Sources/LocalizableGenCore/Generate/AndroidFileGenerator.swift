//
//  AndroidFileGenerator.swift
//  
//
//  Created by Huy Nguyen on 12/04/2022.
//

import Foundation

struct AndroidFileGenerator: FileGenerator {
    var localizableFile: LocalizableFile

    var platform: Platform {
        return .Android
    }

    init(localizableFile: LocalizableFile) {
        self.localizableFile = localizableFile
    }
}
