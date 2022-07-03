//
//  File.swift
//  LocalizableGenerator
//
//  Created by Huy Nguyen on 21/03/2022.
//

import Foundation

struct File: Location {
    let storage: Storage<File>

    init(storage: Storage<File>) {
        self.storage = storage
    }
}

extension File {
    static var kind: LocationKind {
        return .file
    }

    func write(_ data: Data) throws {
        do {
            try data.write(to: url)
        } catch {
            throw WriteError(path: path, reason: .writeFailed(error))
        }
    }

    func write(_ string: String, encoding: String.Encoding = .utf8) throws {
        guard let data = string.data(using: encoding) else {
            throw WriteError(path: path, reason: .stringEncodingFailed(string))
        }

        return try write(data)
    }

    func append(_ data: Data) throws {
        do {
            let handle = try FileHandle(forWritingTo: url)
            handle.seekToEndOfFile()
            handle.write(data)
            handle.closeFile()
        } catch {
            throw WriteError(path: path, reason: .writeFailed(error))
        }
    }

    func append(_ string: String, encoding: String.Encoding = .utf8) throws {
        guard let data = string.data(using: encoding) else {
            throw WriteError(path: path, reason: .stringEncodingFailed(string))
        }

        return try append(data)
    }

    func decode<T: Decodable>(of type: T.Type) throws -> T {
        do {
            let data = try Data(contentsOf: self.url)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw ReadError(path: path, reason: .canNotReadData)
        }
    }

    var data: Data? {
        return try? Data(contentsOf: self.url)
    }
}
