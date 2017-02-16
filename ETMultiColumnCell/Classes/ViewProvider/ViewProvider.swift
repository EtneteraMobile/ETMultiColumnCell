//
//  ViewProvider.swift
//  Pods
//
//  Created by Petr Urban on 13/02/2017.
//
//

import Foundation

// MARK: - CustomView

public protocol ViewProvider {

    var reuseId: String { get }

    func create() -> UIView
    func customize(view view: UIView) throws
    func size(for width: CGFloat) -> CGSize
}
