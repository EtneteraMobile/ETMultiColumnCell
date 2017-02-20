//
//  ETMultiColumnCellError.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 24/01/2017.
//
//

import Foundation

extension ETMultiColumnCell {

    public enum Error: Swift.Error {
        case columnsCountMissmatch(description: String)
        case invalidWidth()
        case insufficientWidth(description: String)
    }
}
