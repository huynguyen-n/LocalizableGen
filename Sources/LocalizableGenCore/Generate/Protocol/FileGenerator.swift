//
//  FileGenerator.swift
//  
//
//  Created by Huy Nguyen on 08/04/2022.
//

import Foundation

//  MARK: - Main File Generator
protocol FileGenerator {

    var localizableFile: LocalizableFile { get }

    var platform: Platform { get }

    var baseDirectory: String { get }

    var localizableFileDirectory: String { get }

    var fileName: String { get }

    var textMacroHeader: String { get }

    var csvDictionaryString: String { get }

    init(localizableFile: LocalizableFile)

    func writeToFile()
}
