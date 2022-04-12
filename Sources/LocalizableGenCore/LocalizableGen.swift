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
        SpreadSheetRequest(spreadSheetId: "1IihX1NXGX98A6MrliAN1pYrxIGhAMWu-BkfgqMco8Pc").excute(onSuccess: { results in
            let csvDictionary = results.valueRanges.first().values.toDictionary(with: 1)
            let localizableFile = LocalizableFile(module: "Common", language: "", data: csvDictionary)
            let generatoriOS = iOSFileGenerator(localizableFile: localizableFile)
            let generatorAndroid = AndroidFileGenerator(localizableFile: localizableFile)
            generatoriOS.writeToFile()
            generatorAndroid.writeToFile()
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

    static func getEmailInfo() -> String {
        do {
            let clientMail = try GoogleOAuth.share.getCredentialEmail()
            return Constant.App.Message.email + clientMail.green()
        } catch {
            return error.asTo(CredentialsError.self).description.red()
        }
    }
}
