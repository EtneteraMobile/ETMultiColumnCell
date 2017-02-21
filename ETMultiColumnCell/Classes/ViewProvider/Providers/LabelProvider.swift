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
        case .oneLine(_): return "OneLineLabel"
        case .multiLine(_): return "MultilineLabel"
        case let .lines(lines): return "MultiLabel-\(lines.count)"
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
        case .oneLine(_): return UILabel()
        case .multiLine(_): return UILabel()
        case let .lines(lines): return MultiLabelsView(withLabelsCount: lines.count)
        }
    }

    public func customize(view: UIView) {
        customize(view, content.style)
    }

    public func size(for width: CGFloat) -> CGSize {
        return size(for: width, content.style)
    }

    // MARK: - Customize and size for recursion

    public func customize(_ view: UIView, _ style: Content.Style) {

        switch style {
        case let .oneLine(attText):
            guard let v = view as? UILabel else { preconditionFailure("Expected: UILabel") }

            v.attributedText = attText

            v.numberOfLines = 1
            v.lineBreakMode = .byTruncatingTail

        case let .multiLine(attText):
            guard let v = view as? UILabel else { preconditionFailure("Expected: UILabel")}

            v.attributedText = attText

            v.numberOfLines = 0
            v.lineBreakMode = .byTruncatingTail

        case let .lines(lines):
            guard let v = view as? MultiLabelsView, let labels = v.subviews as? [UILabel] else { preconditionFailure("Expected: MultiLabelsView") }
            guard lines.count == labels.count else { preconditionFailure("Specs couns different from labels count") }

            labels.enumerated().forEach {
                let lineStyle = lines[$0.offset]
                self.customize($0.element, lineStyle)
            }
        }
    }

    public func size(for width: CGFloat, _ style: Content.Style) -> CGSize {
        switch style {
        case let .oneLine(attText):
            return CGSize(width: width, height: attText.calculateHeight(inWidth: width, isMultiline: false))

        case let .multiLine(attText):
            return CGSize(width: width, height: attText.calculateHeight(inWidth: width, isMultiline: true))

        case let .lines(lines):
            let height = lines.reduce(CGFloat(0.0)) { return $0 + self.size(for: width, $1).height }
            return CGSize(width: width, height: height)
        }
    }
}

// MARK: - LabelProvider.Content

public extension LabelProvider {
    
    public struct Content {
        let style: Style

        public init(style: Style) {
            self.style = style
        }

        public indirect enum Style {
            case oneLine(NSAttributedString)
            case multiLine(NSAttributedString)
            case lines([Style])
        }
    }
}
