//
//  RangeCell.swift
//  
//
//  Created by Huy Nguyen on 20/04/2022.
//

import Foundation

public struct RangeCell<A, B> {
    public private(set) var column: A
    public private(set) var row: B?
    init(column: A, row: B? = nil) {
        self.column = column
        self.row = row
    }
}

extension RangeCell: Encodable where A: Encodable, B: Encodable { }
extension RangeCell: Decodable where A: Decodable, B: Decodable { }
