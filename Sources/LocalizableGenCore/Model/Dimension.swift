//
//  Dimension.swift
//  
//
//  Created by Huy Nguyen on 20/04/2022.
//

import Foundation
import AppKit

public enum Dimension {
    static let COLUMNS = "COLUMNS"
    static let ROWS = "ROWS"
    static let DIMENSION_UNSPECIFIED = "DIMENSION_UNSPECIFIED"

    case columns
    case rows
    case dimensionUnspecified

    var value: String {
        switch self {
        case .columns:
            return Dimension.COLUMNS
        case .rows:
            return Dimension.ROWS
        case .dimensionUnspecified:
            return Dimension.DIMENSION_UNSPECIFIED
        }
    }

    init?(value: String) {
        switch value.uppercased() {
        case Dimension.COLUMNS:
            self = .columns
        case Dimension.ROWS:
            self = .rows
        default:
            self = .dimensionUnspecified
        }
    }
}
