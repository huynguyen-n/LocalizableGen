//
//  Generate.swift
//  
//
//  Created by Huy Nguyen on 01/04/2022.
//

import Foundation
import ArgumentParser

struct Generate: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Generate localizable file from your Spreadsheet.")

    @Argument(help: "The sheet identifier to generate localize files")
    private var sheetIdentifier: String

    @Argument(help: "The module to LocalizableGen create the folder")
    private var moduleName: String

    @Argument(help: "The Google Sheet name from Spreadsheet")
    private var primaryGoogleSheetName: String

    @Argument(help: "The platform of localizable file")
    private var platform: String

    func run() throws {
//        Log.isVerbose = verbose
//
//        let payload = Payload(title: title, body: body, isMutable: isMutable, badge: badge)
//        let jsonData = try JSONEncoder().encode(payload)
//
//        if Log.isVerbose, let object = try? JSONSerialization.jsonObject(with: jsonData, options: []), let jsonString = String(data: try! JSONSerialization.data(withJSONObject: object, options: .prettyPrinted), encoding: .utf8) {
//            Log.debug("Generated payload:\n\n\(jsonString)\n")
//        }
//
//        let tempUrl = NSTemporaryDirectory()
//        let payloadUrl = Foundation.URL(fileURLWithPath: tempUrl, isDirectory: true).appendingPathComponent("payload.json")
//        FileManager.default.createFile(atPath: payloadUrl.path, contents: jsonData, attributes: nil)
//
//        Log.message("Sending push notification...")
//        Self.shell.execute(.push(bundleIdentifier: bundleIdentifier, payloadPath: payloadUrl.path))
//        Log.message("Push notification sent successfully")
//        try FileManager.default.removeItem(at: payloadUrl)
    }

    private func getSpreadSheet() {
        SpreadSheetRequest(spreadSheetId: "1IihX1NXGX98A6MrliAN1pYrxIGhAMWu-BkfgqMco8Pc").excute(onSuccess: { results in
            print(results.valueRanges.first().values.toDictionary(with: 1))
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
}
