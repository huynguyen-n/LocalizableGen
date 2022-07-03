//
//  Update.swift
//  
//
//  Created by Huy Nguyen on 10/05/2022.
//

import Foundation
import ArgumentParser

struct Update: ParsableCommand, LocalizableConfigFilePr {
    public static let configuration = CommandConfiguration(abstract: "Update current localizable file to your Spreadsheet.")

    @Argument(help: "The localizable config file to LocalizableGen work with your sheet")
    private var pathConfigFile: String

    @Flag(name: .shortAndLong, help: "Only update an unique values into Spreadsheet")
    private var uniqueValue = false

    @Flag(name: .shortAndLong, help: "Show extra logging for debugging purposes")
    private var verbose = false

    var path: String {
        return pathConfigFile
    }

    func run() throws {
        Log.isVerbose = verbose

        do {
            try update(try file())
        } catch let locationError as LocationError {
            Log.message(locationError.description.red())
        } catch {
            Log.message(error.asTo(ReadError.self).description.red())
        }
    }

    private func update(_ file: LocalizableConfigFile) throws {
        do {
            try Folder(path: file.stringResourceFolderPath)
                .subFolderFilter(Constant.LocaliableFile.iOS.DirExtension)
                .forEach {
                    try updateSpreadsheet($0, configFile: file)
                }
        } catch {
            Log.message("Error to read Folder", to: .error)
        }
    }

    private func updateSpreadsheet(_ file: File, configFile: LocalizableConfigFile) throws {
        do {
            guard let data = file.data else {
                throw ReadError(path: file.path, reason: .canNotReadData)
            }
            let dict = try PropertyListDecoder().decode([String: String].self, from: data)
            let sheet = Sheet(
                range: .init(sheetName: configFile.primaryGoogleSheetName, cells: .init(column: "A2", row: "B")),
                majorDimension: .columns,
                values: uniqueValue ? dict.withUniqeValue() : dict.build()
            )
            let param = UpdateSpreadSheetParam(spreadSheetId: configFile.googleSheetID, valueInputOption: .raw, data: [sheet])
            UpdateSpreadSheetRequest(param).excute { _ in
                Log.message("Updated \(sheet.range.sheetName.underline()) successfully".green())
            } onError: { $0.logMessage() }
        } catch {
            throw error
        }
    }
}
