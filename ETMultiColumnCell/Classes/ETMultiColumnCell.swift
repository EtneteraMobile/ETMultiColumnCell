//
//  ETMultiColumnCell.swift
//  ETMultiColumnCell
//
//  Created by Jan Čislinský on 20/01/2017.
//
//

import UIKit

/// Configurable multi-column cell
public class ETMultiColumnCell: UITableViewCell {
    
    // MARK: - Variables
    
    // MARK: private
    
    /// Cell configuration structure
    private var config: Configuration
    
    // MARK: - Initialization
    
    /// The only ETMultiColumnCell constructor.
    /// There is set up reuseIdentifier for given content. Subviews are createdl.
    ///
    /// - Parameter config: <#config description#>
    public init(with config: Configuration) {

        self.config = config

        super.init(style: .default, reuseIdentifier: ETMultiColumnCell.identifier(with: config))
        
        setupSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Content

    public override func layoutSubviews() {
        super.layoutSubviews()

        try? customizeColumns(withTextUpdate: false)
    }

    /// Setup subviews based on current configuration.
    private func setupSubviews() {
        for _ in (0..<config.columns.count) {
            self.contentView.addSubview(UILabel())
        }
    }

    /// Customize columns with content from current configuration.
    private func customizeColumns(withTextUpdate: Bool = true) throws {

        let subviewsCount = contentView.subviews.count
        var lastRightEdge: CGFloat = 0.0

        let columnsWithSizes = try self.config.columnsWithSizes(inWidth: frame.size.width)

        columnsWithSizes.enumerated().forEach {

            guard $0.offset < subviewsCount else { return }
            guard let columnLabel = self.contentView.subviews[$0.offset] as? UILabel else { return }

            if withTextUpdate == true {
                columnLabel.attributedText = $0.element.column.attText
            }

            // Layouts
            columnLabel.frame = CGRect(origin: CGPoint(x: lastRightEdge, y: 0.0), size: $0.element.size)
            lastRightEdge = columnLabel.frame.origin.x + columnLabel.frame.size.width
        }
    }

    // MARK: - Actions
    
    // MARK: public
    
    /// Customize cell with content. When layout missmatch configurations occurs, Error is thrown.
    ///
    /// - Parameter config: cell configuration
    /// - Throws: `ETMultiColumnCellError.columnsCountMissmatch`, `ETMultiColumnCellError.heighMissmatch`
    public func customize(with config: Configuration) throws {

        guard self.config.columns.count == config.columns.count else {
            let errorDescription = "expected: \(self.config.columns.count) columns, got: \(config.columns.count) columns"
            throw ETMultiColumnCell.Error.columnsCountMissmatch(description: errorDescription)
        }

        // Updates local config
        self.config = config

        // Customizes content according new configuration
        try customizeColumns()
    }
}

// MARK: - Static

public extension ETMultiColumnCell {

    /// Returns unique identifier for given configuration
    ///
    /// - Parameter config: cell configuration
    /// - Returns: unique string - hash from cell configuaration layout parameters
    public static func identifier(with config: ETMultiColumnCell.Configuration) -> String {

        return NSStringFromClass(ETMultiColumnCell.self) + "-\(config.columns.count)"
    }

    /// Returns height of cell for given configuration
    ///
    /// - Parameter config: cell configuration
    /// - Returns: height of cell for given configuration
    public static func height(with config: ETMultiColumnCell.Configuration, width: CGFloat) -> CGFloat {

        let maxTouple = try! config.columnsWithSizes(inWidth: width).max { lhs, rhs -> Bool in
            return lhs.size.height < rhs.size.height
        }
        return maxTouple?.size.height ?? 0.0
    }
}
