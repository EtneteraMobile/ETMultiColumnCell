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

        // MARK: - Initialization

        public init(columns: [Column]) {
            self.columns = columns
        }

        // MARK: Column configuration

        /// Column configuration structure of ETMultiColumnCell
        public struct Column {

            // MARK: - Variables

            public let layout: Layout
            public let attText: NSAttributedString?
            public let viewProvider: ViewProvider?

            public init(layout: Layout, text: String, font: UIFont = UIFont.boldSystemFont(ofSize: 10.0)) {
                self.layout = layout
                self.attText = NSAttributedString(string: text, attributes: [NSFontAttributeName: font])
                self.viewProvider = nil
            }

            public  init(layout: Layout, text: NSAttributedString) {
                self.layout = layout
                self.attText = text
                self.viewProvider = nil
            }

            public  init(layout: Layout, content viewProvider: ViewProvider) {
                self.layout = layout
                self.viewProvider = viewProvider
                self.attText = nil
            }

            // MARK: - Inner

            /// Layout properties
            ///
            /// - relative: relative size column
            /// - fixed: fixed size column (size as parameter)
            public enum Layout {

                case rel(border: [Border], edges: Edges)
                case fix(width: CGFloat, border: [Border], edges: Edges)

                public static func relative(border: [Border] = [], edges: Edges = .zero) -> Layout {
                    return .rel(border: border, edges: edges)
                }

                public static func fixed(width: CGFloat, border: [Border] = [], edges: Edges = .zero) -> Layout {
                    return .fix(width: width, border: border, edges: edges)
                }

                /// Returns fixed width in case fixed layout. Otherwise returns nil
                ///
                /// - Returns: width (static layout) or nil (relative layout)
                public func fixedWidth() -> CGFloat? {
                    switch self {
                    case .rel(border: _, edges: _):
                        return nil
                    case .fix(width: let width, border: _, edges: _):
                        return width
                    }
                }

                public enum Border {
                    case left(width: CGFloat, color: UIColor)
                    case bottom(width: CGFloat, color: UIColor)
                }

                public enum Edges {

                    case inner(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
                    case zero

                    public static func insets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Edges {
                        return .inner(top: top, left: left, bottom: bottom, right: right)
                    }

                    public static func insets(vertical: CGFloat = 0, horizontal: CGFloat = 0) -> Edges {
                        return .inner(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
                    }

                    public static func insets(all: CGFloat = 0) -> Edges {
                        return .inner(top: all, left: all, bottom: all, right: all)
                    }

                    /// Returns `EdgeInset` generated from self
                    ///
                    /// - Returns: space around content (`EdgeInset`)
                    func insets() -> EdgeInsets {

                        switch self {
                        case let .inner(top: top, left: left, bottom: bottom, right: right):
                            return EdgeInsets(top: top, left: left, bottom: bottom, right: right)
                        default:
                            return EdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                        }
                    }
                }

                /// EdgeInsets
                ///
                /// - top: space from top
                /// - left: space from left
                /// - bottom: space from bottom
                /// - right: space from right
                public struct EdgeInsets {
                    public let top: CGFloat
                    public let left: CGFloat
                    public let bottom: CGFloat
                    public let right: CGFloat

                    public func vertical() -> CGFloat {
                        return top + bottom
                    }

                    public func horizontal() -> CGFloat {
                        return left + right
                    }
                }
            }
        }
    }
}

public extension ETMultiColumnCell.Configuration {

    internal func columnsWithSizes(inWidth width: CGFloat) throws -> [(column: ETMultiColumnCell.Configuration.Column, size: CGSize, edges: Column.Layout.Edges, border: [Column.Layout.Border])] {

        // Is width valid
        guard width > 0.0 else { throw ETMultiColumnCell.Error.invalidWidth() }

        // Calculates fixed columns width sum
        var relativeColumnsCount = 0
        let fixedColumnsWidthSum = columns.reduce(CGFloat(0.0)) {
            guard let width = $1.layout.fixedWidth() else {
                relativeColumnsCount += 1
                return $0
            }
            return $0 + width
        }

        let remainingWidth = width - fixedColumnsWidthSum

        // Is width sufficient
        let description = "Sum width of fixed colums is longer than column width (fixedColumnsWidthSum=\(fixedColumnsWidthSum), columnWidth=\(width))."
        guard remainingWidth > 0.0 else { throw ETMultiColumnCell.Error.insufficientWidth(description: description) }

        let relativeColumnWidth = floor(remainingWidth / CGFloat(relativeColumnsCount))

        // Calculates columns frame
        let result:[(Column, CGSize, Column.Layout.Edges, [Column.Layout.Border])] = try columns.map {

            let edges: Column.Layout.Edges
            let width: CGFloat
            let border: [Column.Layout.Border]

            switch $0.layout {
            case let .rel(border: relativeBorder, edges: relativeEdges):
                border = relativeBorder
                width = relativeColumnWidth
                edges = relativeEdges
            case let .fix(width: fixedWidth, border: fixedBorder, edges: fixedEdges):
                border = fixedBorder
                width = fixedWidth
                edges = fixedEdges
            }

            let verticalEdges = edges.insets().vertical()
            let horizontalEdges = edges.insets().horizontal()

            let inWidth = width - horizontalEdges
            guard inWidth > 0 else { throw ETMultiColumnCell.Error.insufficientWidth(description: "Horizontal edges are longer than cell width (horizontalEdges=\(horizontalEdges), columnWidth=\(width)).") }

            let height: CGFloat

            if let text = $0.attText {
                height = calculateHeight(withText: text, inWidth: inWidth)
            } else if let provider = $0.viewProvider {
                let size = provider.size(for: inWidth)
                height = size.height
                guard size.width <= inWidth else { throw ETMultiColumnCell.Error.insufficientWidth(description: "Width of custom view is loonger than given width of cell content view (provider.viewSize().width=\(size.width), inWidth=\(inWidth)).") }
            } else {
                height = 0
            }

            return ($0, CGSize(width: width, height: height + verticalEdges), edges, border)
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
