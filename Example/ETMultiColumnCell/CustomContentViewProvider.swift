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
    }

    func size(for width: CGFloat) -> CGSize {
        // TODO: Calculate height based on content
        return CGSize(width: width, height: 200.0)
    }
}

extension LabelProvider {

    struct Content {
        let attText: NSAttributedString
    }
}
