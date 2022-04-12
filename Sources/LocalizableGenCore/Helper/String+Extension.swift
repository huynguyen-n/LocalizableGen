//
//  String+Extension.swift
//  
//
//  Created by Huy Nguyen on 11/04/2022.
//

import Foundation

extension String {
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

    func appending(_ pathComponent: String) -> String {
        return self + "/" + pathComponent
    }

    func toAndroid() -> String {
        return self.replacingOccurrences(of: ".", with: "_")
    }
}

