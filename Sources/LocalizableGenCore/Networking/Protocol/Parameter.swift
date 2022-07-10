//
//  Parameter.swift
//
//
//  Created by Huy Nguyen on 05/04/2022.
//

import Foundation

// MARK: - Generic param
public protocol Parameter {
    
    func toDictionary() -> [String: Any]
}
