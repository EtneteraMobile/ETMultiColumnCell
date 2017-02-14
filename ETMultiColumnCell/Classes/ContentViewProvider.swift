//
//  ContentViewProvider.swift
//  Pods
//
//  Created by Petr Urban on 13/02/2017.
//
//

import Foundation

// MARK: - CustomView

public protocol ContentViewProvider {

    func makeView() -> UIView
    func viewIdentifier() -> String
    func viewSize() -> CGSize
    func customize(view view: UIView) throws
}
