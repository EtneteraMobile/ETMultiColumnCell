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

    let cellConfigs = [
        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 50.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 50.0), text: "Hello there!"),
        ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 80.0), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black)), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 60.0, border: .left(width: 1, color: .black)), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black)), text: "Hello there!")
        ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 0)), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black), edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: ViewController.attributedText),
        ]),

        ETMultiColumnCell.Configuration(columns: [
            ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 5)), text: "Hello there!"),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black), edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: ViewController.attributedText),
            ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black)), text: "Hello there!")
        ])
    ]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellConfigs.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return try! ETMultiColumnCell.height(with: cellConfigs[indexPath.row], width: view.frame.size.width)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ETMultiColumnCell(with: cellConfigs[indexPath.row])
        try! cell.customize(with: cellConfigs[indexPath.row])
        return cell
    }

    private static var attributedText: NSAttributedString {

        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        let paragraphStyleRight = NSMutableParagraphStyle()
        paragraphStyleRight.alignment = .right

        let r = NSMutableAttributedString(string: "right alignment with multiline text becaouse of it's length aslhgsadglkhsadg lsadgksadg laksjhdg", attributes: [NSParagraphStyleAttributeName: paragraphStyleRight])
        r.append(NSAttributedString(string: "\n"))
        r.append(NSAttributedString(string: "center jumbotron", attributes: [NSParagraphStyleAttributeName: paragraphStyleCenter, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0)]))
        r.append(NSAttributedString(string: "\n"))
        r.append(NSAttributedString(string: "left multiline text with newline >\n< inside of it", attributes: [NSParagraphStyleAttributeName: paragraphStyleLeft, NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20.0)]))

        return r
    }
}

