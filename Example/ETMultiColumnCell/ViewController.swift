//
//  ViewController.swift
//  ETMultiColumnCell
//
//  Created by Jan Cislinsky on 01/20/2017.
//  Copyright (c) 2017 Jan Cislinsky. All rights reserved.
//

import UIKit
import ETMultiColumnCell

class ViewController: UITableViewController {

    static let padding = ETMultiColumnCell.Configuration.Column.Layout.Edges.insets(vertical: 6, horizontal: 2)
    static let headerAttributes = [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                   NSFontAttributeName: UIFont.boldSystemFont(ofSize: 8),
                                   NSForegroundColorAttributeName: UIColor.red]

    static let imageAttachment = {() -> NSTextAttachment in
                                    let attachment = NSTextAttachment()
                                    attachment.image = UIImage(named: "cze")
                                    attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                                    return attachment
                                   }()

    var dynamicConfig: [ETMultiColumnCell.Configuration] = []

    override func viewDidLoad() {
        tableView.separatorStyle = .none
        let padding = ViewController.padding
        let headerAttributes = ViewController.headerAttributes

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "P",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "Tým",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "Z",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "V",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "VP",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "PP",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "P",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "Skore",
                                                                                                                                  attributes: headerAttributes)))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "Body",
                                                                                                                                  attributes: headerAttributes))))
            ]))

        let C = ETMultiColumnCell.Configuration.self
        let asdg = NSMutableAttributedString(string: "lasjdhglkasdh",
                                          attributes: headerAttributes)
        dynamicConfig.append(C.init(columns: [C.Column(layout: .relative(edges: .insets(vertical: 2, horizontal: 2)),
                                               content: LabelProvider(with: LabelProvider.Content(attText: asdg)))]))

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: .insets(vertical: 2, horizontal: 2)),
                                                   content: BadgeViewProvider(with: BadgeViewProvider.Content(text: "3.", backgroundColor: .gray, textColor: .white))),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                let r = NSMutableAttributedString()
                r.append(NSAttributedString(attachment: ViewController.imageAttachment))
                r.append(NSAttributedString(string: " Mladá Boleslav",
                                            attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                         NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                return r
            }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)], edges: padding),
                                                    content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                                                        let r = NSMutableAttributedString()
                                                        r.append(NSAttributedString(string: "30",
                                                                                    attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                                                                 NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                                                        return r
                                                    }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                    content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                                                        let r = NSMutableAttributedString()
                                                        r.append(NSAttributedString(string: "10",
                                                                                    attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                                                                 NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                                                        return r
                                                    }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                                                    let r = NSMutableAttributedString()
                                                    r.append(NSAttributedString(string: "16",
                                                                                attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                                                             NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                                                    return r
                                                   }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                                                    let r = NSMutableAttributedString()
                                                    r.append(NSAttributedString(string: "4",
                                                                                attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                                                             NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                                                    return r
                                                   }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: {()-> NSAttributedString in
                                                    let r = NSMutableAttributedString()
                                                    r.append(NSAttributedString(string: "4",
                                                                                attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                                                             NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                                                    return r
                                                   }()))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "36:30",
                                                                                                                                  attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding),
                                                   content: LabelProvider(with: LabelProvider.Content(attText: NSAttributedString(string: "58",
                                                                                                                                  attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)])))),
            ]))

        dynamicConfig += DataFactory.dataA
        dynamicConfig += DataFactory.dataB
        dynamicConfig += DataFactory.dataC
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamicConfig.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return try! ETMultiColumnCell.height(with: dynamicConfig[indexPath.row], width: view.frame.size.width)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = ETMultiColumnCell(with: dynamicConfig[indexPath.row])
//        try! cell.customize(with: dynamicConfig[indexPath.row])
        let id = ETMultiColumnCell.identifier(with: dynamicConfig[indexPath.row])

        if let cell = tableView.dequeueReusableCell(withIdentifier: id) {
            return cell
        }

        return ETMultiColumnCell(with: dynamicConfig[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let c = cell as? ETMultiColumnCell else { return }

        try! c.customize(with: dynamicConfig[indexPath.row])
    }

    private static var attributedText: NSAttributedString {

        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        let paragraphStyleRight = NSMutableParagraphStyle()
        paragraphStyleRight.alignment = .right

        let r = NSMutableAttributedString(string: "right alignment with multiline text becaouse of it's length aslhgsadglkhsadg lsadgksadg laksjhdg", attributes: [NSParagraphStyleAttributeName: paragraphStyleRight, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10.0)])
        r.append(NSAttributedString(string: "\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12.0)]))
        r.append(NSAttributedString(string: "center jumbotron", attributes: [NSParagraphStyleAttributeName: paragraphStyleCenter, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0)]))
        r.append(NSAttributedString(string: "\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0)]))
        r.append(NSAttributedString(string: "left multiline text with newline >\n< inside of it", attributes: [NSParagraphStyleAttributeName: paragraphStyleLeft, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10.0)]))

        return r
    }
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

extension CGFloat {

    public static func random(lower: CGFloat = 0, upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }

    public func toString(maximumFractionDigits: Int = 0, minimumFractionDigits: Int = 0) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = maximumFractionDigits
        numberFormatter.maximumFractionDigits = minimumFractionDigits

        let num = NSNumber(value: Float(self))
        return numberFormatter.string(from: num)
    }
}

extension Int {

    public static func random(lower: Int = 0, upper: Int = 1) -> Int {
        return Int(CGFloat.random(lower: CGFloat(lower), upper: CGFloat(upper + 1)))
    }

    public func toString(maximumFractionDigits: Int = 0) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = maximumFractionDigits

        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}

