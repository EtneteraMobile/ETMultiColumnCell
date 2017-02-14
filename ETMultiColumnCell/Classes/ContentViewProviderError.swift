//
//  ContentViewProviderError.swift
//  Pods
//
//  Created by Petr Urban on 14/02/2017.
//
//

import Foundation

public enum ContentViewProviderError: Swift.Error {
    
    case incompatibleContent(description: String)
    case incompatibleView(description: String)
}
