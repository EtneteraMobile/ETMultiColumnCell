//
//  ETMultiColumnCell.swift
//  ETMultiColumnCell
//
//  Created by Jan Čislinský on 20/01/2017.
//
//

import UIKit
import ETMultiColumnView

/// Configurable multi-column cell using `ETMultiColumnView` in internal representation.
public class ETMultiColumnCell: UITableViewCell, MultiColumnConfigurable {

    // MARK: - Variables
    // MARK: private
    private let view: ETMultiColumnView

    // MARK: - Initialization

    public required init(with config: ETMultiColumnView.Configuration) {
        view = ETMultiColumnView(with: config)
        super.init(style: .Default, reuseIdentifier: ETMultiColumnView.identifier(with: config))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    // MARK: public

    public func customize(with config: ETMultiColumnView.Configuration) throws {
        try view.customize(with: config)
    }
}

// MARK: - Static
public extension ETMultiColumnCell {

    public static func identifier(with config: ETMultiColumnView.Configuration) -> String {
        return ETMultiColumnView.identifier(with: config)
    }

    public static func height(with config: ETMultiColumnView.Configuration, width: CGFloat) throws -> CGFloat {
        return try ETMultiColumnView.height(with: config, width: width)
    }
}