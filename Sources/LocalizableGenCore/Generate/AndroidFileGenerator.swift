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

    var textMacroHeader: String {
        let byUser = NSFullUserName()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy 'at' HH:mm:ss"
        let byDate = dateFormatter.string(from: Date())
        return """
            <!--
            //  \(fileName)
            //  \(localizableFile.module)
            //
            //  Created by \(byUser) on \(byDate).
            -->\n\n\n
            """
    }
}
