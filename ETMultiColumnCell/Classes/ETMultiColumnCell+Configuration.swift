//
//  Configuration.swift
//  Pods
//
//  Created by Petr Urban on 24/01/2017.
//
//

import Foundation

// MARK: - Configuration

public extension ETMultiColumnCell {

    /// ETMultiColumnCell configuration structure
    public struct Configuration {

        // MARK: - Variables

        // MARK: public

        /// Array of configuration for each column
        public let columns: [Column]

        // MARK: - Inner

        // MARK: Column configuration

        /// Column configuration structure of ETMultiColumnCell
        public struct Column {

            // MARK: - Variables

            let layout: Layout
            let text: String

            // MARK: - Inner

            /// Layout properties
            ///
            /// - relative: relative size column
            /// - fixed: fixed size column (size as parameter)
            public enum Layout {
                case relative
                case fixed(CGFloat)
            }
        }
    }
}

public extension ETMultiColumnCell.Configuration {

    internal func columnsWithSizes(inWidth width: CGFloat) throws -> [(column: ETMultiColumnCell.Configuration.Column, size: CGSize)] {

        // Is width valid
        guard width > 0.0 else { throw ETMultiColumnCell.Error.invalidWidth() }

        // Calculates fixed columns width sum
        var relativeColumnsCount = 0
        let fixedColumnsWidthSum = columns.reduce(CGFloat(0.0)) {
            guard case let .fixed(w) = $1.layout else {
                relativeColumnsCount += 1
                return $0
            }
            return $0 + w
        }

        let remainingWidth = width - fixedColumnsWidthSum

        // Is width sufficient
        guard remainingWidth > 0.0 else { throw ETMultiColumnCell.Error.insufficientWidth() }

        let relativeColumnWidth = floor(remainingWidth / CGFloat(relativeColumnsCount))

        // Calculates columns sizes
        let result:[(Column, CGSize)] = columns.map {
            var width:CGFloat
            switch $0.layout {
            case .relative:
                width = relativeColumnWidth
            case let .fixed(fixedWidth):
                width = fixedWidth
            }

            let height = calculateHeight(withText: $0.text, inWidth: width)
            return ($0, CGSize(width: width, height: height))
        }

        return result
    }

    // MARK: - Helpers

    private func calculateHeight(withText text: String, font: UIFont = UIFont.systemFont(ofSize: 12), inWidth width: CGFloat) -> CGFloat {

        let layoutingString = NSAttributedString(string: text, attributes: [ NSFontAttributeName: font ])

        // Calculates height manualy
        let boundingRect = layoutingString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingRect.height)
    }
}
