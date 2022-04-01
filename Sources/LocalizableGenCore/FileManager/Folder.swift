//
//  Folder.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

struct Folder: Location {
    let storage: Storage<Folder>

    init(storage: Storage<Folder>) {
        self.storage = storage
    }
}

extension Folder {
    static var kind: LocationKind {
        return .folder
    }

    static var home: Folder {
        return try! Folder(path: "~")
    }

    static var currentDirectoryPath: String {
        return FileManager.default.currentDirectoryPath
    }

    static let temporaryDirectory: String = NSTemporaryDirectory()

    static let credentialsFilePath: String = temporaryDirectory.appending(Constant.OAuth.Credentials.fileName)

    @discardableResult
    func createFile(named fileName: String, contents: Data? = nil) throws -> File {
        return try storage.createFile(at: fileName, contents: contents)
    }
}
