//
//  SingleLineLabelProvider.swift
//  Pods
//
//  Created by Petr Urban on 16/02/2017.
//
//

import Foundation

public struct SingleLineLabelProvider: ViewProvider {

    // MARK: - Variables

    // MARK: public

    public let reuseId = "LabelProvider" // same id as id for LabelProvider on purpose

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    public init(with content: Content) {
        self.content = content
    }

    // MARK: - Content

    public func create() -> UIView {
        return UILabel()
    }

    public func customize(view: UIView) throws {

        guard let v = view as? UILabel else { throw ViewProviderError.incompatibleView(description: "expected: UILabel") }
        v.attributedText = content.attText
        v.numberOfLines = 1
        v.adjustsFontSizeToFitWidth = false
        v.lineBreakMode = NSLineBreakMode.byTruncatingTail

    }

    public func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: calculateHeight(withText: content.attText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}

public extension SingleLineLabelProvider {
    
    struct Content {
        let attText: NSAttributedString

        public init(attText: NSAttributedString) {
            self.attText = attText
        }
    }
}
