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

    var model: [ETMultiColumnCell.Configuration] = []

    override func viewDidLoad() {
        tableView.separatorStyle = .none
        navigationController?.setNavigationBarHidden(true, animated: false)

        model += DataFactory.dataHeader
        model += DataFactory.dataWithIcon
        model += DataFactory.dataA
        model += DataFactory.dataB
        model += DataFactory.dataC
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return try! ETMultiColumnCell.height(with: model[indexPath.row], width: view.frame.size.width)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = ETMultiColumnCell.identifier(with: model[indexPath.row])

        if let cell = tableView.dequeueReusableCell(withIdentifier: id) {
            return cell
        }

        return ETMultiColumnCell(with: model[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let c = cell as? ETMultiColumnCell else { return }

        try! c.customize(with: model[indexPath.row])
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

