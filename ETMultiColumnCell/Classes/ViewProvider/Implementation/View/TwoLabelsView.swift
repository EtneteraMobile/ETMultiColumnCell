//
//  TwoLabelsView.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 15/02/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class TwoLabelsView: UIView {

    let firstLine = UILabel()
    let secondLine = UILabel()

    override var frame: CGRect {
        didSet {
            firstLine.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height/2)
            secondLine.frame = CGRect(x: 0, y: frame.height/2, width: frame.width, height: frame.height/2)
        }
    }

    init() {
        super.init(frame: .zero)

        setup()
    }

    private func setup() {
        addSubview(firstLine)
        addSubview(secondLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
