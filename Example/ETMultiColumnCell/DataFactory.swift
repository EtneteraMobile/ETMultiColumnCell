//
//  DataFactory.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 15/02/2017.
//

import Foundation
import ETMultiColumnCell

struct DataFactory {

    private static let padding = ETMultiColumnCell.Configuration.Column.Layout.Edges.insets(vertical: 6, horizontal: 2)
    private static let headerAttributes = [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                   NSFontAttributeName: UIFont.boldSystemFont(ofSize: 8),
                                   NSForegroundColorAttributeName: UIColor.red]

    private static let imageAttachment = {() -> NSTextAttachment in
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "cze")
        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
        return attachment
    }()

    static var dataHeader: [ETMultiColumnCell.Configuration] {

        var dynamicConfig: [ETMultiColumnCell.Configuration] = []

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            createColumn(
                .fixed(width: 25.0, edges: padding),
                .multiLine(createAtt("P", headerAttributes))),

            createColumn(
                .relative(edges: padding),
                .multiLine(createAtt("Tým", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("Z", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("V", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("VP", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("PP", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("P", headerAttributes))),

            createColumn(
                .fixed(width: 40.0, edges: padding),
                .multiLine(createAtt("Skóre", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("Body", headerAttributes))),
        ]))

        return dynamicConfig
    }

    static var dataWithIcon: [ETMultiColumnCell.Configuration] {

        var dynamicConfig: [ETMultiColumnCell.Configuration] = []

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            createColumn(
                .fixed(width: 30.0, edges: padding),
                BadgeViewProvider(with: BadgeViewProvider.Content(text: "3.", backgroundColor: .gray, textColor: .white))),

            createColumn(
                .relative(edges: padding),
                .multiLine({()-> NSAttributedString in
                    let r = NSMutableAttributedString()
                    r.append(NSAttributedString(attachment: imageAttachment))
                    r.append(NSAttributedString(string: " Mladá Boleslav",
                                                attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                             NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                    return r
                }())),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("30", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("10", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("16", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("4", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("4", headerAttributes))),

            createColumn(
                .fixed(width: 40.0, edges: padding),
                .multiLine(createAtt("36:30", headerAttributes))),

            createColumn(
                .fixed(width: 30.0, edges: padding),
                .multiLine(createAtt("58", headerAttributes))),
            ]))

        return dynamicConfig
    }

    static var dataA: [ETMultiColumnCell.Configuration] {
        var dynamicConfig: [ETMultiColumnCell.Configuration] = []

        for i in 0...20 {
            let customViewColor = UIColor.init(red: CGFloat.random(lower: 0.2, upper: 0.8), green: CGFloat.random(lower: 0.2, upper: 0.8), blue: CGFloat.random(lower: 0.2, upper: 0.8), alpha: 1)

            let style: LabelProvider.Content.Style
            if Int.random(lower: 0, upper: 1) == 1 {
                style = .oneLine(createAtt("\(String.random(length: Int.random(lower: 10, upper: 20))) \(String.random(length: Int.random(lower: 2, upper: 12)))", 10))
            } else {
                style = .multiLine(createAtt("\(String.random(length: Int.random(lower: 8, upper: 20))) \(String.random(length: Int.random(lower: 6, upper: 12)))", 10))
            }

            let colors = Int.random(lower: 0, upper: 1) == 1 ? (UIColor.clear, UIColor.black) : (customViewColor, UIColor.white)
            let badgeOrNotColumnConfig = createColumn(
                .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2), verticalAlignment: .middle),
                BadgeViewProvider(with: BadgeViewProvider.Content(text: "\(i).", backgroundColor: colors.0, textColor: colors.1)))

            let cell = ETMultiColumnCell.Configuration(columns: [
                badgeOrNotColumnConfig,
                createColumn(
                    .relative(edges: padding, verticalAlignment: .middle),
                    style),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .middle),
                             .multiLine(createAtt(Int.random(lower: 20, upper: 100).toString(), 10))),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .middle),
                             .multiLine(createAtt(Int.random(lower: 2, upper: 20).toString(), 10))),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .middle),
                             .multiLine(createAtt(Int.random(lower: 20, upper: 20).toString(), 10))),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .top),
                             .multiLine(createAtt(Int.random(lower: 20, upper: 20).toString(), 10))),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .top),
                             .multiLine(createAtt(Int.random(lower: 20, upper: 20).toString(), 10))),

                createColumn(.fixed(width: 40.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .bottom),
                             .multiLine(createAtt(Int.random(lower: 2, upper: 50).toString() + ":" + Int.random(lower: 2, upper: 50).toString(), 10))),

                createColumn(.fixed(width: 30.0, borders: [.left(width: 1, color: .blue)], edges: padding, verticalAlignment: .bottom),
                             .multiLine(createAtt(Int.random(lower: 20, upper: 100).toString(), 10))),
            ])

            dynamicConfig.append(cell)
        }
        
        return dynamicConfig
    }

    static var dataB: [ETMultiColumnCell.Configuration] {

        var dynamicConfig: [ETMultiColumnCell.Configuration] = []

        for _ in 0...100 {
            let cell = ETMultiColumnCell.Configuration(columns: [
                createColumn(
                    .fixed(width: 40.0, borders: [.left(width: 1, color: .blue)], edges: padding),
                    .lines([.oneLine(createAtt("12.10.")), .oneLine(createAtt("2015", 10))])),

                createColumn(
                    .relative(edges: padding),
                    .lines([.multiLine(createAtt("FIRST \(String.random(length: Int.random(lower: 8, upper: 20)))")), .multiLine(createAtt("second \(String.random(length: Int.random(lower: 20, upper: 40)))", 10))])),
                
                createColumn(
                    .relative(edges: padding, verticalAlignment: .middle),
                    .oneLine(createAtt("\(String.random(length: Int.random(lower: 8, upper: 20))) \(String.random(length: Int.random(lower: 6, upper: 12)))"))),

                createColumn(
                    .fixed(width: 40.0, edges: padding),
                    .multiLine(createAtt(Int.random(lower: 0, upper: 10).toString() + ":" + Int.random(lower: 0, upper: 10).toString()))),

                createColumn(
                    .fixed(width: 10.0, edges: padding),
                    .multiLine(createAtt("")))
            ])

            dynamicConfig.append(cell)
        }

        return dynamicConfig
    }

    static var dataC: [ETMultiColumnCell.Configuration] {

        var dynamicConfig: [ETMultiColumnCell.Configuration] = []

        for _ in 0...100 {

            let cell = ETMultiColumnCell.Configuration(columns: [
                createColumn(
                    .relative(edges: padding),
                    .multiLine(createAtt(String.random(length: Int.random(lower: 6, upper: 40))))),

                createColumn(
                    .fixed(width: 30.0, edges: padding),
                    .multiLine(createAtt(Int.random(lower: 0, upper: 15).toString()))),

                createColumn(
                    .relative(borders: [.left(width: 1, color: .lightGray)], edges: padding),
                    .multiLine(createAtt(String.random(length: Int.random(lower: 6, upper: 40))))),

                createColumn(
                    .fixed(width: 30.0, edges: padding),
                    .multiLine(createAtt(Int.random(lower: 0, upper: 15).toString())))
                ])

            dynamicConfig.append(cell)
        }

        return dynamicConfig
    }

    // MAKR: - Helper methods

    private static func createAtt(_ string: String, _ attributes: [String: Any]) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: attributes)
    }

    private static func createAtt(_ string: String, _ size: CGFloat = 12) -> NSAttributedString {
        return NSAttributedString(string: string, attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)])
    }

    private static func createColumn(_ layout: ETMultiColumnCell.Configuration.Column.Layout, _ style: LabelProvider.Content.Style) -> ETMultiColumnCell.Configuration.Column {
        LabelProvider.Content(style: style)
        let c = LabelProvider.Content(style: style)
        let p = LabelProvider(with: c)
        return ETMultiColumnCell.Configuration.Column(layout: layout, content: p)
//        return ETMultiColumnCell.Configuration.Column(layout: layout, content: LabelProvider(with: LabelProvider.Content(style: style)))
    }

    private static func createColumn(_ layout: ETMultiColumnCell.Configuration.Column.Layout, _ provider: ViewProvider) -> ETMultiColumnCell.Configuration.Column {
        return ETMultiColumnCell.Configuration.Column(layout: layout, content: provider)
    }
}

// MARK: - Helpers extensions

private extension String {

    static func random(length: Int = 20) -> String {
        let base = " abcd efghi jklmno pqrstuvw xyzABCD EFGHIJKL MNOPQ RSTUV WXYZ0 123456 789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

private extension CGFloat {

    static func random(lower: CGFloat = 0, upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }

    func toString(maximumFractionDigits: Int = 0, minimumFractionDigits: Int = 0) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = maximumFractionDigits
        numberFormatter.maximumFractionDigits = minimumFractionDigits

        let num = NSNumber(value: Float(self))
        return numberFormatter.string(from: num)
    }
}

private extension Int {

    static func random(lower: Int = 0, upper: Int = 1) -> Int {
        return Int(CGFloat.random(lower: CGFloat(lower), upper: CGFloat(upper + 1)))
    }

    func toString(maximumFractionDigits: Int = 0) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maximumFractionDigits

        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
