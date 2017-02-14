//
//  CustomContentViewProvider.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 13/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ETMultiColumnCell

struct CustomContentViewProvider: ContentViewProvider {

    let content: Content

    init(with content: Content) {

        self.content = content
    }

    func makeView() -> UIView {
        return CustomView()
    }

    func viewIdentifier() -> String {
        return "asdasdasdasddasd"
    }

    func customize(view: UIView) throws {
        guard let customView = view as? CustomView else { throw ContentViewProviderError.incompatibleView(description: "expected: CustomView") }

        customView.customize(text: content.text, backgroundColor: content.backgroundColor, textColor: content.textColor)
    }

    func viewSize() -> CGSize {
        return CGSize(width: 20, height: 20)
    }

    struct Content {
        let text: String
        let backgroundColor: UIColor
        let textColor: UIColor
    }
}
