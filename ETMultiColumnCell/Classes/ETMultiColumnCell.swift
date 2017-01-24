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
    
    // MARK: Private
    
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
    
    // MARK: - Setup
    
    /// Setup subviews based on current configuration.
    private func setupSubviews() {
        for _ in config.columns {
            contentView.addSubview(UILabel())
        }
    }
    
    
    /// Customize columns with content from current configuration.
    private func customizeColumns() {
        
        for (index, columnConfig) in config.columns.enumerated() {
            // TODO: switch to types - image/text,...
            if let view = contentView.subviews[index] as? UILabel {
                view.text = columnConfig.text
            }
        }
    }

    // MARK: - Actions
    
    // MARK: - Instance
    
    /// Customize cell with content. When layout missmatch configurations occurs, Error is thrown.
    ///
    /// - Parameter config: cell configuration
    /// - Throws: `ETMultiColumnCellError.layoutMissmatch`, `ETMultiColumnCellError.heighMissmatch`
    public func customize(with config: Configuration) throws {
        
        guard config.layoutHash() == self.config.layoutHash() else {
            let description = "expected: " + self.config.layoutHash() + " got: " + config.layoutHash()
            throw ETMultiColumnCellError.layoutMissmatch(description: description)
        }
        
        guard ETMultiColumnCell.height(with: config) == ETMultiColumnCell.height(with: self.config) else {
            let description = "expected: \(ETMultiColumnCell.height(with: self.config)) got: \(ETMultiColumnCell.height(with: config))"
            throw ETMultiColumnCellError.heighMissmatch(description: description)
        }
        
        self.config = config
        customizeColumns()
    }
    
    // MARK: - Static
    
    
    /// Returns unique identifier for given configuration
    ///
    /// - Parameter config: cell configuration
    /// - Returns: unique string - hash from cell configuaration layout parameters
    public static func identifier(with config: ETMultiColumnCell.Configuration) -> String {
        
        return  NSStringFromClass(ETMultiColumnCell.self) + "-" + config.layoutHash() + "-" + "\(height(with: config))"
    }
    
    
    /// Returns height of cell for given configuration
    ///
    /// - Parameter config: cell configuration
    /// - Returns: height of cell for given configuration
    public static func height(with config: ETMultiColumnCell.Configuration) -> CGFloat {
        
        // TODO: calculate based on config
        return 44
    }
}
