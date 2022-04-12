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

    static var root: Folder {
        return try! Folder(path: "/")
    }

    /// The current user's Documents folder
    static var documents: Folder? {
        return try? .matching(.documentDirectory)
    }

    static var localizableGenDir: URL {
        return documents!.url.appendingPathComponent(Constant.App.TargetName)
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

    @discardableResult
    func createSubfolder(named name: String) throws -> Folder {
        return try storage.createSubfolder(at: name)
    }

    static func matching(
        _ searchPath: FileManager.SearchPathDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        resolvedBy fileManager: FileManager = .default
    ) throws -> Folder {
        let urls = fileManager.urls(for: searchPath, in: domain)

        guard let match = urls.first else {
            throw LocationError(
                path: "",
                reason: .unresolvedSearchPath(searchPath, domain: domain)
            )
        }

        return try Folder(storage: Storage(
            path: match.relativePath,
            fileManager: fileManager
        ))
    }
}

extension URL {
    var pathWithSlash: String {
        return self.path + "/"
    }
}
