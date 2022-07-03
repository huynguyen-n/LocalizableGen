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

    struct ChildSequence<Child: Location>: Sequence {
        let folder: Folder
        let fileManager: FileManager
        var isRecursive: Bool
        var includeHidden: Bool

        public func makeIterator() -> ChildIterator<Child> {
            return ChildIterator(
                folder: folder,
                fileManager: fileManager,
                isRecursive: isRecursive,
                includeHidden: includeHidden,
                reverseTopLevelTraversal: false
            )
        }
    }

    struct ChildIterator<Child: Location>: IteratorProtocol {
        private let folder: Folder
        private let fileManager: FileManager
        private let isRecursive: Bool
        private let includeHidden: Bool
        private let reverseTopLevelTraversal: Bool
        private lazy var itemNames = loadItemNames()
        private var index = 0
        private var nestedIterators = [ChildIterator<Child>]()

        init(folder: Folder,
                         fileManager: FileManager,
                         isRecursive: Bool,
                         includeHidden: Bool,
                         reverseTopLevelTraversal: Bool) {
            self.folder = folder
            self.fileManager = fileManager
            self.isRecursive = isRecursive
            self.includeHidden = includeHidden
            self.reverseTopLevelTraversal = reverseTopLevelTraversal
        }

        public mutating func next() -> Child? {
            guard index < itemNames.count else {
                guard var nested = nestedIterators.first else {
                    return nil
                }

                guard let child = nested.next() else {
                    nestedIterators.removeFirst()
                    return next()
                }

                nestedIterators[0] = nested
                return child
            }

            let name = itemNames[index]
            index += 1

            if !includeHidden {
                guard !name.hasPrefix(".") else { return next() }
            }

            let isDirNameiOS = folder.url.lastPathComponent.contains(Constant.LocaliableFile.iOS.DirExtension) ?
            "/" : ""
            let childPath = folder.path + isDirNameiOS + name.removingPrefix("/")
            let childStorage = try? Storage<Child>(path: childPath, fileManager: fileManager)
            let child = childStorage.map(Child.init)

            if isRecursive {
                let childFolder = (child as? Folder) ?? (try? Folder(
                    storage: Storage(path: childPath, fileManager: fileManager)
                ))

                if let childFolder = childFolder {
                    let nested = ChildIterator(
                        folder: childFolder,
                        fileManager: fileManager,
                        isRecursive: true,
                        includeHidden: includeHidden,
                        reverseTopLevelTraversal: false
                    )

                    nestedIterators.append(nested)
                }
            }

            return child ?? next()
        }

        private mutating func loadItemNames() -> [String] {
            let contents = try? fileManager.contentsOfDirectory(atPath: folder.path)
            let names = contents?.sorted() ?? []
            return reverseTopLevelTraversal ? names.reversed() : names
        }
    }

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

    var subfolders: ChildSequence<Folder> {
        return storage.makeChildSequence()
    }

    var files: ChildSequence<File> {
        return storage.makeChildSequence()
    }

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

    @discardableResult
    func subFolderFilter(_ element: String) throws -> [File] {
        var files: [File] = []
        subfolders
            .filter { $0.url.lastPathComponent.contains(element) }
            .forEach {
                files = Array($0.files)
            }
        return files
    }
}

extension URL {
    var pathWithSlash: String {
        return self.path + "/"
    }
}
