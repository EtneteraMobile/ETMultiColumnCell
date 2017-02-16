//
//  DataFactory.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 15/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import ETMultiColumnCell

struct DataFactory {

    static var dataA: [ETMultiColumnCell.Configuration] {
        get {
            var dynamicConfig: [ETMultiColumnCell.Configuration] = []

            let padding = ViewController.padding

            for i in 0...20 {
                let customViewColor = UIColor.init(red: CGFloat.random(lower: 0.2, upper: 0.8), green: CGFloat.random(lower: 0.2, upper: 0.8), blue: CGFloat.random(lower: 0.2, upper: 0.8), alpha: 1)

                let content: ViewProvider
                if Int.random(lower: 0, upper: 1) == 1 {
                    content = SingleLineLabelProvider(with: SingleLineLabelProvider.Content(attText: NSAttributedString(string: "\(String.random(length: Int.random(lower: 10, upper: 20))) \(String.random(length: Int.random(lower: 2, upper: 12)))",
                        attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))
                } else {
                    content = LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "\(String.random(length: Int.random(lower: 8, upper: 20))) \(String.random(length: Int.random(lower: 6, upper: 12)))",
                        attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))
                }

                let badgeOrNotColumnConfig: ETMultiColumnCell.Configuration.Column
                if Int.random(lower: 0, upper: 1) == 1 {
                    badgeOrNotColumnConfig = ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2), verticalAlignment: .middle),
                                                                                    content: BadgeViewProvider(with: BadgeViewProvider.Content(text: "\(i).", backgroundColor: .clear, textColor: .black)))
                } else {
                    badgeOrNotColumnConfig = ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2), verticalAlignment: .middle),
                                                                                    content: BadgeViewProvider(with: BadgeViewProvider.Content(text: "\(i).", backgroundColor: customViewColor, textColor: .white)))
                }

                let cell = ETMultiColumnCell.Configuration(columns: [
                    badgeOrNotColumnConfig,
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding),
                                                           content: content),

                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)], edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 20, upper: 100).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),


                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 20).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 20).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 20).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 20).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 50).toString() + ":" + Int.random(lower: 2, upper: 50).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 2, upper: 100).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
                    ])
                
                dynamicConfig.append(cell)
            }
            
            return dynamicConfig
        }
    }

    static var dataB: [ETMultiColumnCell.Configuration] {
        get {
            var dynamicConfig: [ETMultiColumnCell.Configuration] = []

            let padding = ViewController.padding

            for _ in 0...100 {

                let content = TwoLabelsViewProvider.Content(firstAttText: NSAttributedString(string: "FIRST \(String.random(length: Int.random(lower: 8, upper: 20)))", attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]),
                                                          secondAttText: NSAttributedString(string: "second \(String.random(length: Int.random(lower: 8, upper: 20)))", attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))

                let contentDate = TwoLabelsViewProvider.Content(firstAttText: NSAttributedString(string: "12.10.", attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]),
                                                              secondAttText: NSAttributedString(string: "2015", attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))

                let cell = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, border: [.left(width: 1, color: .blue)], edges: padding),
                                                           content: TwoLabelsViewProvider(with: contentDate)),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding),
                                                           content: TwoLabelsViewProvider(with: content)),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding, verticalAlignment: .middle),
                                                           content: SingleLineLabelProvider(with: SingleLineLabelProvider.Content(attText: NSAttributedString(string: "\(String.random(length: Int.random(lower: 8, upper: 20))) \(String.random(length: Int.random(lower: 6, upper: 12)))",
                                                            attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 0, upper: 10).toString() + ":" + Int.random(lower: 0, upper: 10).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 10.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "",
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]))))
                    ])

                dynamicConfig.append(cell)
            }

            return dynamicConfig
        }
    }

    static var dataC: [ETMultiColumnCell.Configuration] {
        get {
            var dynamicConfig: [ETMultiColumnCell.Configuration] = []

            let padding = ViewController.padding

            for _ in 0...100 {

                let cell = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "Bogulski Ondrej",
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 0, upper: 15).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(border: [.left(width: 1, color: .lightGray)], edges: padding),
                                                           content: SingleLineLabelProvider(with: SingleLineLabelProvider.Content(attText: NSAttributedString(string: "Lopez Cabrera",
                                                            attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                           content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: Int.random(lower: 0, upper: 15).toString(),
                                                                                                                                          attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)])))),
                    ])

                dynamicConfig.append(cell)
            }

            return dynamicConfig
        }
    }

}
