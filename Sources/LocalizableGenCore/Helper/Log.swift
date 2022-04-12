//
//  Log.swift
//  
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation
import ColorizeSwift

enum OutputType {
    case error
    case standard
}

enum Log {
    static var isVerbose: Bool = false

    static func debug(_ message: Any) {
        guard isVerbose else { return }
        print(message)
    }

    static func message(_ message: String, to: OutputType = .standard) {
        switch to {
        case .error:
            fputs("Error: \(message)\n".red(), stderr)
        case .standard:
            print("\(message)")
        }
    }

    static func message(_ data: Data, to: OutputType = .standard) {
        do {
            let JSONObj = try JSONSerialization.jsonObject(with: data, options: [])
            let JSONObjData = try JSONSerialization.data(withJSONObject: JSONObj, options: .prettyPrinted)
            let JSONStr = String(data: JSONObjData, encoding: .utf8) ?? ""
            message(JSONStr, to: to)
        } catch { }
    }
}
