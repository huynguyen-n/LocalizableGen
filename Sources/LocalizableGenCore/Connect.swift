//
//  Connect.swift
//  
//
//  Created by Huy Nguyen on 01/04/2022.
//

import Foundation
import ArgumentParser

struct Connect: ParsableCommand {
    public static let configuration = CommandConfiguration(abstract: "Check the connection to your Spreadsheet by added service account email.")

    @Argument(help: "The sheet identifier to generate localize files")
    private var sheetIdentifier: String
}
