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

            init(layout: Layout, text: NSAttributedString) {
                self.layout = layout
                self.attText = text
            }

            // MARK: - Inner

            /// Layout properties
            ///
            /// - relative: relative size column
            /// - fixed: fixed size column (size as parameter)
            public enum Layout {

                case relative(edges: Edges)
                case fixed(width: CGFloat, edges: Edges)

                public enum Edges {

                    case inner(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
                    case zero
                }
            }


        }
    }
}

public extension ETMultiColumnCell.Configuration {

    internal func columnsWithSizes(inWidth width: CGFloat) throws -> [(column: ETMultiColumnCell.Configuration.Column, size: CGSize, edges: Column.Layout.Edges)] {

        // Is width valid
        guard width > 0.0 else { throw ETMultiColumnCell.Error.invalidWidth() }

        // Calculates fixed columns width sum
        var relativeColumnsCount = 0
        let fixedColumnsWidthSum = columns.reduce(CGFloat(0.0)) {
            guard case let .fixed(width: w, edges: _) = $1.layout else {
                relativeColumnsCount += 1
                return $0
            }
            return $0 + w
        }

        let remainingWidth = width - fixedColumnsWidthSum

        // Is width sufficient
        let description = "Sum width of fixed colums is longer than column width (fixedColumnsWidthSum=\(fixedColumnsWidthSum), columnWidth=\(width))."
        guard remainingWidth > 0.0 else { throw ETMultiColumnCell.Error.insufficientWidth(description: description) }

        let relativeColumnWidth = floor(remainingWidth / CGFloat(relativeColumnsCount))

        // Calculates columns frame
        let result:[(Column, CGSize, Column.Layout.Edges)] = try columns.map {

            let edges: Column.Layout.Edges
            let width:CGFloat

            switch $0.layout {
            case let .relative(edges: relativeEdges):
                width = relativeColumnWidth
                edges = relativeEdges
            case let .fixed(width: fixedWidth, edges: fixedEdges):
                width = fixedWidth
                edges = fixedEdges
            }

            let verticalEdges: CGFloat
            let horizontalEdges: CGFloat

            switch edges {
            case let .inner(top: top, left: left, bottom: bottom, right: right):
                horizontalEdges = left + right
                verticalEdges = top + bottom
            case let .zero:
                horizontalEdges = 0
                verticalEdges = 0
            }

            let inWidth = width - horizontalEdges
            guard inWidth > 0 else { throw ETMultiColumnCell.Error.insufficientWidth(description: "Horizontal edges are longer than cell width (horizontalEdges=\(horizontalEdges), columnWidth=\(width)).") }

            let height = calculateHeight(withText: $0.attText, inWidth: width - horizontalEdges)
            return ($0, CGSize(width: width, height: height + verticalEdges), edges)
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
