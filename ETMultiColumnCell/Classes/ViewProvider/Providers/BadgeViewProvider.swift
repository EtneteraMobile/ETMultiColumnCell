//
//  BadgeViewProvider.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 16/02/2017.
//
//

import Foundation

// MARK: - BadgeViewProvider

/// Provides implementation of `ViewProvider` that creates `BadgeView` as column.
public struct BadgeViewProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    public let reuseId = "BadgeViewIdentifier"
    public var font: UIFont?
    public var textInset: CGFloat?

    // MARK: private

    private let content: Content
    private let size: CGSize?

    // MARK: - Initialization
    /// When size is nil, then size of view will be computed based on cell width
    /// like `CGSize(width: width, height: width)`
    ///
    /// - Parameters:
    ///   - content: BadgeViewProvider.Content
    ///   - size: custom view size
    public init(with content: Content, with size: CGSize? = nil) {
        self.size = size
        self.content = content
    }

    // MARK: - ViewProvider

    public func create() -> UIView {
        return BadgeView(font: font, textInset: textInset)
    }

    public func customize(view: UIView) throws {
        guard let customView = view as? BadgeView else { throw ViewProviderError.incompatibleView(description: "expected: BadgeView") }

        customView.customize(text: content.text, backgroundColor: content.backgroundColor, textColor: content.textColor)
    }

    public func size(for width: CGFloat) -> CGSize {
        return size ?? CGSize(width: width, height: width)
    }
}

// MARK: - BadgeViewProvider.Content

public extension BadgeViewProvider {

    public struct Content {
        let text: String
        let backgroundColor: UIColor
        let textColor: UIColor

        public init(text: String, backgroundColor: UIColor, textColor: UIColor) {
            self.text = text
            self.backgroundColor = backgroundColor
            self.textColor = textColor
        }
    }
}
