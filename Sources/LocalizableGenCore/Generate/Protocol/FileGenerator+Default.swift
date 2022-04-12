//
//  FileGenerator+Default.swift
//  
//
//  Created by Huy Nguyen on 11/04/2022.
//

import Foundation

extension FileGenerator {

    var fileName: String {
        switch platform {
        case .iOS:
            return Constant.LocaliableFile.iOS.Name
        case .Android:
            return Constant.LocaliableFile.Android.Name
        }
    }

    var baseDirectory: String {
        return Folder.localizableGenDir.pathWithSlash
    }

    var localizableFileDirectory: String {
        let module = localizableFile.module
        let language = localizableFile.language
        let languageDirectoryExtention = platform.dirExtension(language)
        return "\(module)/\(platform.value)/\(languageDirectoryExtention)/"
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

    var csvDictionaryString: String {
        return localizableFile.data.toCSVString(for: platform)
    }

    func writeToFile() {
        do {
            let folder = try Folder(path: baseDirectory)
            let subFolder = try folder.createSubfolder(named: localizableFileDirectory)
            let file = try subFolder.createFile(named: fileName)

            var str = textMacroHeader
            str += csvDictionaryString
            try file.write(str)
        } catch let locationErr as LocationError {
            Log.message(locationErr.description, to: .error)
        } catch let fileErr as WriteError {
            Log.message(fileErr.description, to: .error)
        } catch {
            Log.message(error.localizedDescription, to: .error)
        }
    }
}
