//
//  ViewProvider.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 13/02/2017.
//
//

import Foundation

/// Protocol describes mandatory functionality of instance that is able to be
/// used in column of `ETMultiColumnCell`.
public protocol ViewProvider {

    /// Reuse identifier used for reuse of cell.
    var reuseId: String { get }

    /// FReturns new instance of view that is presented in column of cell.
    func create() -> UIView

    /// Customizes given view with content before show.
    func customize(view view: UIView)

    /// Returns size of view respecting given width. Height should be dynamicaly
    /// calculated based on content.
    func size(for width: CGFloat) -> CGSize
}
