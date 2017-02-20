//
//  LabelProvider.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 16/02/2017.
//
//

import Foundation

// MARK: - LabelProvider

public struct LabelProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    public var reuseId: String {
        switch content.style {
        case .multiLine(_): return "MultilineLabel"
        case .oneLine(_): return "OneLineLabel"
        case .twoLabel(_): return "TwoLabel"
        }
    }

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    public init(with content: Content) {
        self.content = content
    }

    // MARK: - ViewProvider

    public func create() -> UIView {
        switch content.style {
        case .multiLine(_): return UILabel()
        case .oneLine(_): return UILabel()
        case .twoLabel(_): return TwoLabelsView()
        }
    }

    public func customize(view: UIView) throws {

        switch content.style {
        case let .multiLine(attText):
            guard let v = view as? UILabel else { throw ViewProviderError.incompatibleView(description: "expected: UILabel") }

            v.attributedText = attText

            v.numberOfLines = 0
            v.lineBreakMode = .byClipping

        case let .oneLine(attText):
            guard let v = view as? UILabel else { throw ViewProviderError.incompatibleView(description: "expected: UILabel") }

            v.attributedText = attText

            v.numberOfLines = 1
            v.lineBreakMode = .byTruncatingTail

        case let .twoLabel(firstAttText, secondAttText):
            guard let v = view as? TwoLabelsView else { throw ViewProviderError.incompatibleView(description: "expected: TwoLabelsView") }

            v.firstLine.attributedText = firstAttText
            v.firstLine.numberOfLines = 1
            v.firstLine.adjustsFontSizeToFitWidth = false
            v.firstLine.lineBreakMode = .byTruncatingTail

            v.secondLine.attributedText = secondAttText
            v.secondLine.numberOfLines = 1
            v.secondLine.adjustsFontSizeToFitWidth = false
            v.secondLine.lineBreakMode = .byTruncatingTail
        }
    }

    public func size(for width: CGFloat) -> CGSize {
        switch content.style {
        case let .multiLine(attText):
            return CGSize(width: width, height: calculateHeight(withText: attText, inWidth: width))

        case let .oneLine(attText):
            return CGSize(width: width, height: calculateHeight(withText: attText, inWidth: width))

        case let .twoLabel(firstAttText, secondAttText):
            return CGSize(width: width, height: calculateHeight(withText: firstAttText, inWidth: width) + calculateHeight(withText: secondAttText, inWidth: width))
        }
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy
        let boundingRect:CGRect

        switch content.style {
        case let .multiLine(attText):
            boundingRect = attText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        case let .oneLine(attText):
            boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        case let .twoLabel(firstAttText, secondAttText):
            boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        }

        return ceil(boundingRect.height)
    }
}

// MARK: - LabelProvider.Content

public extension LabelProvider {
    
    public struct Content {
        let style: Style

        public init(style: Style) {
            self.style = style
        }

        public enum Style {
            case multiLine(NSAttributedString)
            case oneLine(NSAttributedString)
            case twoLabel(NSAttributedString, NSAttributedString)
        }
    }
}
