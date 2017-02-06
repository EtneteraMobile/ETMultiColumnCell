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
            let attText: NSAttributedString


            init(layout: Layout, text: String) {
                self.layout = layout
                self.attText = NSAttributedString(string: text)
            }

            init(layout: Layout, attText: NSAttributedString) {
                self.layout = layout
                self.attText = attText
            }

            // MARK: - Inner

            /// Layout properties
            ///
            /// - relative: relative size column
            /// - fixed: fixed size column (size as parameter)
            public enum Layout {

                case relative(inner: Edges?)
                case fixed(width: CGFloat, inner: Edges?)

                // MARK: - Inner

                public struct Edges {
                    let top: CGFloat?
                    let left: CGFloat?
                    let bottom: CGFloat?
                    let right: CGFloat?

                    init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
                        self.top = top
                        self.left = left
                        self.bottom = bottom
                        self.right = right
                    }
                }
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
            guard case let .fixed(width: w, inner: _) = $1.layout else {
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
            case let .fixed(width: fixedWidth, inner: _):
                width = fixedWidth
            }

            let height = calculateHeight(withText: $0.attText, inWidth: width)
            return ($0, CGSize(width: width, height: height))
        }

        return result
    }

    // MARK: - Helpers

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy
        let boundingRect = attText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingRect.height)
    }
}
