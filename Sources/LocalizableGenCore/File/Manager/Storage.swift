//
//  Storage.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

enum LocationKind {
    case file
    case folder
}

protocol Location: CustomStringConvertible {
    static var kind: LocationKind { get }
    var storage: Storage<Self> { get }
    init(storage: Storage<Self>)
}

extension Location {
    var description: String {
        let typeName = String(describing: type(of: self))
        return "\(typeName)(name: \(name), path: \(path))"
    }

    var path: String {
        return storage.path
    }

    var url: URL {
        return URL(fileURLWithPath: path)
    }

    var name: String {
        return url.pathComponents.last!
    }

    init(path: String) throws {
        try self.init(storage: Storage(
            path: path,
            fileManager: .default
        ))
    }
}

final class Storage<LocationType: Location> {
    private(set) var path: String
    private let fileManager: FileManager

    init(path: String, fileManager: FileManager) throws {
        self.path = path
        self.fileManager = fileManager
    }
}

extension Storage {
    func makeParentPath(for path: String) -> String? {
        guard path != "/" else { return nil }
        let url = URL(fileURLWithPath: path)
        let components = url.pathComponents.dropFirst().dropLast()
        guard !components.isEmpty else { return "/" }
        return "/" + components.joined(separator: "/") + "/"
    }
}

extension Storage where LocationType == Folder {

    func makeChildSequence<T: Location>() -> Folder.ChildSequence<T> {
        return Folder.ChildSequence(
            folder: Folder(storage: self),
            fileManager: fileManager,
            isRecursive: false,
            includeHidden: false
        )
    }

    func createSubfolder(at folderPath: String) throws -> Folder {
        let folderPath = path + folderPath.removingPrefix("/")

        guard folderPath != path else {
            throw WriteError(path: folderPath, reason: .emptyPath)
        }

        do {
            try fileManager.createDirectory(
                atPath: folderPath,
                withIntermediateDirectories: true
            )

            let storage = try Storage(path: folderPath, fileManager: fileManager)
            return Folder(storage: storage)
        } catch {
            throw WriteError(path: folderPath, reason: .folderCreationFailed(error))
        }
    }

    func createFile(at filePath: String, contents: Data?) throws -> File {
        let filePath = path + filePath.removingPrefix("/")

        guard let parentPath = makeParentPath(for: filePath) else {
            throw WriteError(path: filePath, reason: .emptyPath)
        }

        if parentPath != path {
            do {
                try fileManager.createDirectory(
                    atPath: parentPath,
                    withIntermediateDirectories: true
                )
            } catch {
                throw WriteError(path: parentPath, reason: .folderCreationFailed(error))
            }
        }

        guard fileManager.createFile(atPath: filePath, contents: contents),
              let storage = try? Storage<File>(path: filePath, fileManager: fileManager) else {
            throw WriteError(path: filePath, reason: .fileCreationFailed)
        }

        return File(storage: storage)
    }
}

extension Folder.ChildSequence {
    var first: Child? {
        var iterator = makeIterator()
        return iterator.next()
    }

    var recursive: Folder.ChildSequence<Child> {
        var sequence = self
        sequence.isRecursive = true
        return sequence
    }
}
