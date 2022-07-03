//
//  FilesError.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

struct FilesError<Reason>: Error {
    var path: String

    var reason: Reason

    init(path: String, reason: Reason) {
        self.path = path
        self.reason = reason
    }
}

extension FilesError: CustomStringConvertible {
    var description: String {
        return """
            Files encountered an error at '\(path)'\n
            Reason: \(reason)
            """
    }
}

enum LocationErrorReason {
    case missing
    case emptyFilePath
    case unresolvedSearchPath(
        FileManager.SearchPathDirectory,
        domain: FileManager.SearchPathDomainMask
    )
}

enum WriteErrorReason {
    case emptyPath
    case folderCreationFailed(Error)
    case fileCreationFailed
    case writeFailed(Error)
    case stringEncodingFailed(String)
}

enum ReadErrorReason {
    case canNotReadData
}


typealias LocationError = FilesError<LocationErrorReason>
typealias WriteError = FilesError<WriteErrorReason>
typealias ReadError = FilesError<ReadErrorReason>
