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

    let cellConfigs = [

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: padding), text: {()-> NSAttributedString in
                 let r = NSMutableAttributedString(string: "P",
                                                   attributes: headerAttributes)
                    return r
                }()),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Tým",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Z",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "V",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "VP",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "PP",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "P",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Skóre",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "B",
                                                  attributes: headerAttributes)
                return r
            }()),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2)),
                                                   content: CustomViewProvider(with: CustomViewProvider.Content(text: "3.", backgroundColor: .gray, textColor: .white))),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: [.left(width: 1, color: .blue)], edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString()
                r.append(NSAttributedString(attachment: imageAttachment))
                r.append(NSAttributedString(string: " Mladá Boleslav",
                                            attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                         NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "10"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "16"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "4"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "4"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: "36:30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "58"),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(top: 6, left: 4, bottom: 6, right: 0)),
                                                   text: "59."),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: "Chomutov"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "12"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "9"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "1"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "9"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: "41:37"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "45"),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2)),
                                                   content: CustomViewProvider(with: CustomViewProvider.Content(text: "44.", backgroundColor: .red, textColor: .white))),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: "Chomutov"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "12"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "9"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "1"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "9"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: "41:37"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "45"),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 60.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: [.left(width: 3, color: .red)], edges: .inner(top: 15, left: 50, bottom: 15, right: 0)), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)]), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: .inner(top: 30, left: 0, bottom: 15, right: 0)), text: "Hello there!"),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 60.0), text: "Border!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: [.left(width: 3, color: .red)], edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)]), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: .inner(top: 30, left: 0, bottom: 15, right: 0)), text: "Hello there!"),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 80.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 60.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 0)), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: ViewController.attributedText),
            ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 5)), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
            ])
    ]

    override func viewDidLoad() {
        tableView.separatorStyle = .none
        let padding = ViewController.padding
        let headerAttributes = ViewController.headerAttributes

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "P",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Tým",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Z",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "V",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "VP",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "PP",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "P",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "Skóre",
                                                  attributes: headerAttributes)
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString(string: "B",
                                                  attributes: headerAttributes)
                return r
            }()),
            ]))

        let C = ETMultiColumnCell.Configuration.self
        let asdg = NSMutableAttributedString(string: "lasjdhglkasdh",
                                          attributes: headerAttributes)
        dynamicConfig.append(C.init(columns: [C.Column(layout: .relative(edges: .insets(vertical: 2, horizontal: 2)),
                                               content: LabelProvider(with: LabelProvider.Content(attText: asdg)))]))

        dynamicConfig.append(ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2)),
                                                   content: CustomViewProvider(with: CustomViewProvider.Content(text: "3.", backgroundColor: .gray, textColor: .white))),
            ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: {()-> NSAttributedString in
                let r = NSMutableAttributedString()
                r.append(NSAttributedString(attachment: ViewController.imageAttachment))
                r.append(NSAttributedString(string: " Mladá Boleslav",
                                            attributes: [NSParagraphStyleAttributeName: NSParagraphStyle.default,
                                                         NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10)]))
                return r
            }()),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)], edges: padding), text: "30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "10"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "16"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "4"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "4"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: "36:30"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: "58"),
            ]))

        for i in 0...1000 {
            let customViewColor = UIColor.init(red: CGFloat.random(lower: 0.2, upper: 0.8), green: CGFloat.random(lower: 0.2, upper: 0.8), blue: CGFloat.random(lower: 0.2, upper: 0.8), alpha: 1)

            let cell = ETMultiColumnCell.Configuration(columns: [
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 25.0, edges: .insets(vertical: 2, horizontal: 2)),
                                                       content: CustomViewProvider(with: CustomViewProvider.Content(text: "\(i).", backgroundColor: customViewColor, textColor: .white))),
                ETMultiColumnCell.Configuration.Column(layout: .relative(edges: padding), text: "\(String.random(length: Int.random(lower: 4, upper: 8))) \(String.random(length: Int.random(lower: 2, upper: 5)))"),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, border: [.left(width: 1, color: .blue)], edges: padding), text: Int.random(lower: 20, upper: 100).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: Int.random(lower: 2, upper: 20).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: Int.random(lower: 2, upper: 20).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: Int.random(lower: 2, upper: 20).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: Int.random(lower: 2, upper: 20).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: padding), text: Int.random(lower: 2, upper: 50).toString() + ":" + Int.random(lower: 2, upper: 50).toString()),
                ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 30.0, edges: padding), text: Int.random(lower: 2, upper: 100).toString()),
                ])

            dynamicConfig.append(cell)
        }
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

