//
//  Generate.swift
//  
//
//  Created by Huy Nguyen on 01/04/2022.
//

import Foundation
import ArgumentParser

struct Generate: ParsableCommand, LocalizableConfigFilePr {
    public static let configuration = CommandConfiguration(abstract: "Generate localizable file from your Spreadsheet.")

    @Argument(help: "The localizable config file to LocalizableGen work with your sheet")
    private var pathConfigFile: String

    @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes")
    private var verbose = false

    var path: String {
        return pathConfigFile
    }

    func run() throws {
        Log.isVerbose = verbose
        do {
            generate(with: try file())
        } catch let locationError as LocationError {
            Log.message(locationError.description.red())
        } catch {
            Log.message(error.asTo(ReadError.self).description.red())
        }
    }

    private func generate(with config: LocalizableConfigFile) {
        let range = Range(sheetName: config.primaryGoogleSheetName, cells: .init(column: "A1"))
        let sheet = Sheet(range: range, majorDimension: .columns)
        let queryItem = GetSpreadSheetRequestQueryItem(spreadSheetId: config.googleSheetID, sheet: sheet)
        GetSpreadSheetRequest(queryItem: queryItem).excute { results in
            let values = results.valueRanges.first().values
            let csvDictionary = values.toDictionary(with: 1)
            if Log.isVerbose { csvDictionary.print() }
            let localizableFile = LocalizableFile(module: range.sheetName,
                                                  language: values.language,
                                                  data: csvDictionary)
            if let platform = Platform(string: config.platform) {
                switch platform {
                case .iOS:
                    let iOSGen = iOSFileGenerator(localizableFile: localizableFile)
                    iOSGen.writeToFile()
                case .Android:
                    let androidGen = AndroidFileGenerator(localizableFile: localizableFile)
                    androidGen.writeToFile()
                }
                Log.message("Generated \(config.primaryGoogleSheetName.underline()) successfully!!!".green())
            }
        } onError: { $0.logMessage() }
    }
}


