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
}

