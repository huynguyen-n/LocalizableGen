//
//  LocalizableGen.swift
//  
//
//  Created by Huy Nguyen on 31/03/2022.
//

import Foundation
import ArgumentParser
import ColorizeSwift

public struct LocalizableGen: ParsableCommand {

    public static var configuration = CommandConfiguration(
        abstract: Constant.App.Message.intro + "\n" + getEmailInfo(),
        subcommands: [Generate.self]
    )

    public init() {
        try? GoogleOAuth.share.connect()
//        readLocalizableConfig(path: "/Users/huy/Desktop/LocalizedStringsGenerator.json")
//        readLocalizableFile(path: "/Users/huy/RedAirship/iOS/frank-ios/Frank/")
        getAndGenFileFromSpreadSheet()
    }

    private func readLocalizableConfig(path: String) {
        do {
            let file = try File(path: path)
            let data = try Data(contentsOf: file.url)
            let configFile = try JSONDecoder().decode(LocalizableConfigFile.self, from: data)
            Log.message(configFile.googleSheetID)
        } catch {
            Log.message("Failed to read localizable config file", to: .error)
        }
    }

    private func readLocalizableFile(path: String) {
        do {
            try Folder(path: path)
                .subfolders
                .filter { $0.url.lastPathComponent.contains(Constant.LocaliableFile.iOS.DirExtension) }
                .forEach { folder in
                    folder.files.forEach { file in
                        do {
                            let data = try Data(contentsOf: file.url)
                            let dict = try PropertyListDecoder().decode([String: String].self, from: data)
                            var specificDict: [String: String] = [:]
                            for (key, value) in dict {
                                guard key.hasPrefix("signup") else {
                                    continue
                                }
                                specificDict[key] = value
                            }
                            let sheet = Sheet(
                                range: .init(sheetName: "Signup", cells: .init(column: "A2", row: "B")),
                                majorDimension: .columns,
                                values: [
                                    [String](dict.keys),
                                    [String](dict.values)
                                ]
                            )
                            self.updateSpreadSheet(sheet)
                        } catch {
                            Log.message("Error to read", to: .error)
                        }
                    }
                }
        } catch {
            Log.message("Error to read Folder", to: .error)
        }
    }

    private func getAndGenFileFromSpreadSheet() {
        let range = Range(sheetName: "All", cells: .init(column: "A1"))
        let sheet = Sheet(range: range, majorDimension: .columns)
        let queryItem = GetSpreadSheetRequestQueryItem(spreadSheetId: "1IihX1NXGX98A6MrliAN1pYrxIGhAMWu-BkfgqMco8Pc", sheet: sheet)
        GetSpreadSheetRequest(queryItem: queryItem).excute(onSuccess: { results in
            Log.message("Success get data")
//            let values = results.valueRanges.first().values
//            let csvDictionary = values.toDictionary(with: 1)
//            let localizableFile = LocalizableFile(module: range.sheetName,
//                                                  language: values.language,
//                                                  data: csvDictionary)
//
//            let generatoriOS = iOSFileGenerator(localizableFile: localizableFile)
//            let generatorAndroid = AndroidFileGenerator(localizableFile: localizableFile)
//            generatoriOS.writeToFile()
//            generatorAndroid.writeToFile()
        }, onError: { error in
            switch error {
            case .invalidURL:
                break
            case .nilData:
                break
            case .parseJSON(let data):
                Log.message(data, to: .error)
            case .error(let error):
                break
            }
        })
    }

    private func updateSpreadSheet(_ sheet: Sheet) {
        let param = UpdateSpreadSheetParam(spreadSheetId: "", valueInputOption: .raw, data: [sheet])
        UpdateSpreadSheetRequest(param).excute { _ in

        } onError: { error in
            Log.message("Error when update spread sheet")
            switch error {
            case .invalidURL:
                break
            case .nilData:
                break
            case .parseJSON(let data):
                Log.message(data, to: .error)
            case .error(let error):
                break
            }
        }
    }

    static func getEmailInfo() -> String {
        do {
            let clientMail = try GoogleOAuth.share.getCredentialEmail()
            return Constant.App.Message.email + clientMail.green()
        } catch {
            return error.asTo(CredentialsError.self).description.red()
        }
    }
}
