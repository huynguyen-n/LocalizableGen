//
//  QueryItem.swift
//  
//
//  Created by Huy Nguyen on 20/04/2022.
//

import Foundation

// MARK: - Generic query items
public protocol QueryItem {

    func toArray() -> [URLQueryItem]
}
