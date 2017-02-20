//
//  Configuration.swift
//  ETMultiColumnCell
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

        // MARK: - Initialization

        public init(columns: [Column]) {
            self.columns = columns
        }
    }
}

// MARK: - Configuration.Column

public extension ETMultiColumnCell.Configuration {

    /// Column configuration structure of ETMultiColumnCell
    public struct Column {

        // MARK: - Variables

        public let layout: Layout
        public let viewProvider: ViewProvider

        // MARK: - Initialization

        public init(layout: Layout, content viewProvider: ViewProvider) {
            self.layout = layout
            self.viewProvider = viewProvider
        }
    }
}

// MARK: - Configuration.Column.Layout

public extension ETMultiColumnCell.Configuration.Column {

    /// Layout properties
    ///
    /// - relative: relative size column
    /// - fixed: fixed size column (size as parameter)
    public enum Layout {

        // MARK: - Cases

        case rel(borders: [Border], edges: Edges, verticalAlignment: VerticalAlignment)
        case fix(width: CGFloat, borders: [Border], edges: Edges, verticalAlignment: VerticalAlignment)

        // MARK: - Builders

        public static func relative(borders: [Border] = [], edges: Edges = .zero, verticalAlignment: VerticalAlignment = .top) -> Layout {
            return .rel(borders: borders, edges: edges, verticalAlignment: verticalAlignment)
        }

        public static func fixed(width: CGFloat, borders: [Border] = [], edges: Edges = .zero, verticalAlignment: VerticalAlignment = .top) -> Layout {
            return .fix(width: width, borders: borders, edges: edges, verticalAlignment: verticalAlignment)
        }

        /// Returns fixed width in case fixed layout. Otherwise returns nil
        ///
        /// - Returns: width (static layout) or nil (relative layout)
        public func fixedWidth() -> CGFloat? {
            switch self {
            case .rel(borders: _, edges: _, verticalAlignment: _):
                return nil
            case .fix(width: let width, borders: _, edges: _, verticalAlignment: _):
                return width
            }
        }
    }
}

// MARK: - Configuration.Column.Layout additions

public extension ETMultiColumnCell.Configuration.Column.Layout {

    public enum Border {
        case left(width: CGFloat, color: UIColor)
    }

    public enum VerticalAlignment {
        case top
        case middle
        case bottom
    }
}

// MARK: - Configuration.Column.Layout.Edges

public extension ETMultiColumnCell.Configuration.Column.Layout {

    public enum Edges {

        // MARK: - Cases

        case inner(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
        case zero

        // MARK: - Builders

        public static func insets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Edges {
            return .inner(top: top, left: left, bottom: bottom, right: right)
        }

        public static func insets(vertical: CGFloat = 0, horizontal: CGFloat = 0) -> Edges {
            return .inner(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
        }

        public static func insets(all: CGFloat = 0) -> Edges {
            return .inner(top: all, left: all, bottom: all, right: all)
        }

        // MARK: - Insets

        /// Returns `EdgeInset` generated from self
        ///
        /// - Returns: space around content (`EdgeInset`)
        func insets() -> Insets {

            switch self {
            case let .inner(top: top, left: left, bottom: bottom, right: right):
                return Insets(top: top, left: left, bottom: bottom, right: right)
            default:
                return Insets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }

        /// Insets
        ///
        /// - top: space from top
        /// - left: space from left
        /// - bottom: space from bottom
        /// - right: space from right
        public struct Insets {
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
