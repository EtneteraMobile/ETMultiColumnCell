//
//  ETMultiColumnCellError.swift
//  Pods
//
//  Created by Petr Urban on 24/01/2017.
//
//

import Foundation

extension ETMultiColumnCell {

    enum Error: Swift.Error {
        case columnsCountMissmatch(description: String)
        case invalidWidth()
        case insufficientWidth()
    }
}
