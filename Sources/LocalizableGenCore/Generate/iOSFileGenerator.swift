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

    var textMacroHeader: String {
        let byUser = NSFullUserName()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' HH:mm:ss"
        let byDate = dateFormatter.string(from: Date())
        return """
            //
            //  \(fileName)
            //  \(localizableFile.module)
            //
            //  Created by \(byUser) on \(byDate).
            //\n\n\n
            """
    }
}
