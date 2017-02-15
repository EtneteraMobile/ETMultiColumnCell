//
//  CustomViewProvider.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 13/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ETMultiColumnCell

struct CustomViewProvider: ViewProvider {

    let reuseId = "asdhasdfhj"

    private let content: Content

    init(with content: Content) {

        self.content = content
    }

    // MARK: - Delegate
    // MARK: ViewProvider

    func create() -> UIView {
        return CustomView()
    }

    func customize(view: UIView) throws {
        guard let customView = view as? CustomView else { throw ViewProviderError.incompatibleView(description: "expected: CustomView") }

        customView.customize(text: content.text, backgroundColor: content.backgroundColor, textColor: content.textColor)
    }

    func size(for width: CGFloat) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
}

// MARK: - CustomViewProvider.Content

extension CustomViewProvider {

    struct Content {
        let text: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }
}


struct LabelProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    let reuseId = "asdghjas"

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    init(with content: Content) {
        self.content = content
    }

    // MARK: - Content

    func create() -> UIView {

        return UILabel()
    }

    func customize(view: UIView) throws {

        guard let v = view as? UILabel else { throw ViewProviderError.incompatibleView(description: "expected: UILabel") }

        v.attributedText = content.attText

        v.numberOfLines = 0
        v.lineBreakMode = .byClipping
    }

    func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: calculateHeight(withText: content.attText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingRect.height)
    }
}

extension LabelProvider {

    struct Content {
        let attText: NSAttributedString
    }
}

struct SingleLineLabelProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    let reuseId = "asdghjas"

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    init(with content: Content) {
        self.content = content
    }

    // MARK: - Content

    func create() -> UIView {
        return UILabel()
    }

    func customize(view: UIView) throws {

        guard let v = view as? UILabel else { throw ViewProviderError.incompatibleView(description: "expected: UILabel") }
        v.attributedText = content.attText
        v.numberOfLines = 1
        v.adjustsFontSizeToFitWidth = false
        v.lineBreakMode = NSLineBreakMode.byTruncatingTail

    }

    func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: calculateHeight(withText: content.attText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}

extension SingleLineLabelProvider {
    
    struct Content {
        let attText: NSAttributedString
    }
}

struct TwoLabelsViewProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    let reuseId = "asdghjas2Linesasda"

    // MARK: private

    private let content: Content

    // MARK: - Initialization

    init(with content: Content) {
        self.content = content
    }

    // MARK: - Content

    func create() -> UIView {
        return TwoLabelsView()
    }

    func customize(view: UIView) throws {

        guard let v = view as? TwoLabelsView else { throw ViewProviderError.incompatibleView(description: "expected: TwoLineView") }

        v.firstLine.attributedText = content.firstAttText
        v.firstLine.numberOfLines = 1
        v.firstLine.adjustsFontSizeToFitWidth = false
        v.firstLine.lineBreakMode = NSLineBreakMode.byTruncatingTail

        v.secondLine.attributedText = content.secondAttText
        v.secondLine.numberOfLines = 1
        v.secondLine.adjustsFontSizeToFitWidth = false
        v.secondLine.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }

    func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: calculateHeight(withText: content.firstAttText, inWidth: width) + calculateHeight(withText: content.secondAttText, inWidth: width))
    }

    private func calculateHeight(withText attText: NSAttributedString, inWidth width: CGFloat) -> CGFloat {

        // Calculates height manualy

        let boundingRect = attText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        return ceil(boundingRect.height)
    }
}

extension TwoLabelsViewProvider {
    
    struct Content {
        let firstAttText: NSAttributedString
        let secondAttText: NSAttributedString
    }
}

