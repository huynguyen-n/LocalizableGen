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
        abstract: Constant.App.Message.intro + connectGoogleOAuth(),
        subcommands: [
            Generate.self,
            Update.self
        ]
    )

    public init() { }

    static func connectGoogleOAuth() -> String {
        do {
            try GoogleOAuth.share.connect()
            let clientMail = try GoogleOAuth.share.getCredentialEmail()
            return clientMail.green()
        } catch let tokenProviderErr as TokenProviderError {
            return tokenProviderErr.description.red()
        } catch {
            return error.asTo(CredentialsError.self).description.red()
        }
    }
}
