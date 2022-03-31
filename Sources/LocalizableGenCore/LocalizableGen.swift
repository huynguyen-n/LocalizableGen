//
//  LocalizableGen.swift
//  
//
//  Created by Huy Nguyen on 31/03/2022.
//

import Foundation
import ArgumentParser

public struct LocalizableGen: ParsableCommand {

    public static var configuration = CommandConfiguration(
        abstract: "A Swift command-line tool to easily generate localizable file from Google Sheet.",
        subcommands: []
    )

    public init() { }
}
