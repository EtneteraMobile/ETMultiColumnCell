//
//  TwoLabelsViewProvider.swift
//  Pods
//
//  Created by Petr Urban on 16/02/2017.
//
//

import Foundation

public struct TwoLabelsViewProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    public let reuseId = "TwoLabelsViewProvider"

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    public init(with content: Content) {
        self.content = content
    }

    // MARK: - Content

    public func create() -> UIView {
        return TwoLabelsView()
    }

    public func customize(view: UIView) throws {

        guard let v = view as? TwoLabelsView else { throw ViewProviderError.incompatibleView(description: "expected: TwoLabelsView") }

        v.firstLine.attributedText = content.firstAttText
        v.firstLine.numberOfLines = 1
        v.firstLine.adjustsFontSizeToFitWidth = false
        v.firstLine.lineBreakMode = NSLineBreakMode.byTruncatingTail

        v.secondLine.attributedText = content.secondAttText
        v.secondLine.numberOfLines = 1
        v.secondLine.adjustsFontSizeToFitWidth = false
        v.secondLine.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }

    public func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: calculateHeight(withText: content.firstAttText, inWidth: width) + calculateHeight(withText: content.secondAttText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}

public extension TwoLabelsViewProvider {

    public struct Content {
        let firstAttText: NSAttributedString
        let secondAttText: NSAttributedString

        public init(firstAttText: NSAttributedString, secondAttText: NSAttributedString) {
            self.firstAttText = firstAttText
            self.secondAttText = secondAttText
        }
    }
}
