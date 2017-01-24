//
//  ETMultiColumnCellError.swift
//  Pods
//
//  Created by Petr Urban on 24/01/2017.
//
//

import Foundation

enum ETMultiColumnCellError: Error {
    case layoutMissmatch(description: String)
    case heighMissmatch(description: String)
}
