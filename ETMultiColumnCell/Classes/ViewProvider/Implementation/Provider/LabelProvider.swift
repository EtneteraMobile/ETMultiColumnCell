//
//  LabelProvider.swift
//  Pods
//
//  Created by Petr Urban on 16/02/2017.
//
//

import Foundation

public struct LabelProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    public let reuseId = "LabelProvider"

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

        v.numberOfLines = 0
        v.lineBreakMode = .byClipping
    }

    public func size(for width: CGFloat) -> CGSize {
        return CGSize(width: width, height: calculateHeight(withText: content.attText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}

public extension LabelProvider {
    
    public struct Content {
        let attText: NSAttributedString

        public init(attText: NSAttributedString) {
            self.attText = attText
        }
    }
}
