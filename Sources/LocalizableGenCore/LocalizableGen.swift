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
        subcommands: []
    )

    public init() { }

    static func getEmailInfo() -> String {
        do {
            let clientMail = try GoogleOAuth.share.getCredentialEmail()
            return Constant.App.Message.email + clientMail.green()
        } catch {
            return error.asTo(CredentialsError.self).description.red()
        }
    }
}
