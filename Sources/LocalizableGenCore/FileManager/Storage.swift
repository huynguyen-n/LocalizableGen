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
    fileprivate private(set) var path: String
    private let fileManager: FileManager

    fileprivate init(path: String, fileManager: FileManager) throws {
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

private extension String {
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }

    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }

    func appendingSuffixIfNeeded(_ suffix: String) -> String {
        guard !hasSuffix(suffix) else { return self }
        return appending(suffix)
    }
}

