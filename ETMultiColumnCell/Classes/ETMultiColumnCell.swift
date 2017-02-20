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
    private let borderLayer: CALayer
    private let path = UIBezierPath()
    
    // MARK: - Initialization
    
    /// The only ETMultiColumnCell constructor.
    /// There is set up reuseIdentifier for given content. Subviews are createdl.
    ///
    /// - Parameter config: <#config description#>
    public init(with config: Configuration) {

        self.config = config
        borderLayer = CALayer()

        super.init(style: .default, reuseIdentifier: ETMultiColumnCell.identifier(with: config))
        
        setupSubviews()
        layer.addSublayer(borderLayer)
//        borderLayer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Content

    public override func layoutSubviews() {
        super.layoutSubviews()

        guard frame != .zero else {
            return
        }
        
        try? customizeColumns()
    }

    /// Setup subviews based on current configuration.
    private func setupSubviews() {

        config.columns.forEach { columnConfig in
            contentView.addSubview(columnConfig.viewProvider.create())
            borderLayer.addSublayer(CAShapeLayer())
        }
    }

    /// Customize columns with content from current configuration.
    private func customizeColumns() throws {

        let subviewsCount = contentView.subviews.count
        var lastRightEdge: CGFloat = 0.0

        let columnsWithSizes = try config.columnsWithSizes(in: frame.size.width)
        let maxHeight = ETMultiColumnCell.maxHeight(columnsSizes: columnsWithSizes)

        borderLayer.frame = bounds

        columnsWithSizes.enumerated().forEach {

            guard $0.offset < subviewsCount else { return }

            let subview = self.contentView.subviews[$0.offset]

            try? config.columns[$0.offset].viewProvider.customize(view: subview)

            let edgeInsets = $0.element.edges.insets()

            let layer = borderLayer.sublayers?[$0.offset]

            let columnSize = CGSize(width: $0.element.size.width, height: frame.height)
            layer?.frame = CGRect(origin: CGPoint(x: lastRightEdge, y: 0), size: columnSize)

            if $0.element.borders.count == 0 {
                hideBorders(column: layer)
            }

            $0.element.borders.forEach {
                switch $0 {
                case let .left(width: borderWidth, color: borderColor):
                    showLeftBorder(column: layer, width: borderWidth, color: borderColor)
                }
            }

            let contentSize: CGSize
            let inWidth = $0.element.size.width - edgeInsets.horizontal()

            contentSize = config.columns[$0.offset].viewProvider.size(for: inWidth)

            let topAlignShift: CGFloat

            switch $0.element.alignment {
            case .bottom:
                topAlignShift = maxHeight - contentSize.height - edgeInsets.bottom
            case .middle:
                topAlignShift = (maxHeight - edgeInsets.vertical() + contentSize.height)/2 - contentSize.height + edgeInsets.top
            case .top:
                topAlignShift = edgeInsets.top
            }

            // Layouts
            subview.frame = CGRect(origin: CGPoint(x: lastRightEdge + edgeInsets.left, y: topAlignShift), size: contentSize)

            let columnWidth = $0.element.size.width

            lastRightEdge += columnWidth
        }
    }


    // WARNING: This implementation can only draw one border (color, width) to one column!
    /// Will show left border with given properties (color, width)
    ///
    /// - Parameters:
    ///   - layer: expects CAShapeLayer
    ///   - width: border width
    ///   - color: border color
    private func showLeftBorder(column layer: CALayer?, width: CGFloat, color: UIColor) {
        guard let sublayer = layer as? CAShapeLayer else { return }

        path.removeAllPoints()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: frame.height))

        sublayer.path = path.cgPath
        sublayer.strokeColor = color.cgColor
        sublayer.lineWidth = width
    }

    private func hideBorders(column layer: CALayer?) {
        guard let sublayer = layer as? CAShapeLayer else { return }

        sublayer.path = nil
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

        var customViewsIdentifier = ""

        config.columns.enumerated().forEach { (index, column) in
            customViewsIdentifier.append("\(index)")
            customViewsIdentifier.append(column.viewProvider.reuseId)
        }

        return NSStringFromClass(ETMultiColumnCell.self) + "-\(config.columns.count)" + customViewsIdentifier
    }

    /// Returns height of cell for given configuration
    ///
    /// - Parameter config: cell configuration
    /// - Returns: height of cell for given configuration
    public static func height(with config: ETMultiColumnCell.Configuration, width: CGFloat) throws -> CGFloat {

        return maxHeight(columnsSizes: try config.columnsWithSizes(in: width))
    }

    internal static func maxHeight(columnsSizes: [Configuration.ColumnWrapper]) -> CGFloat {
        let maxTouple = columnsSizes.max { lhs, rhs -> Bool in
            return lhs.size.height < rhs.size.height
        }

        return maxTouple?.size.height ?? 0
    }
}
