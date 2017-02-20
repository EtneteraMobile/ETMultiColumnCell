//
//  TwoLabelsView.swift
//  ETMultiColumnCell
//
//  Created by Petr Urban on 15/02/2017.
//

import UIKit

/// View holds two labels that are layouted above each other (as two lines).
class TwoLabelsView: UIView {

    // MARK: - Variables
    // MARK: public
    let firstLine = UILabel()
    let secondLine = UILabel()

    override var frame: CGRect {
        didSet {
            let half = ceil(frame.height/2)
            firstLine.frame = CGRect(x: 0, y: 0, width: frame.width, height: half)
            secondLine.frame = CGRect(x: 0, y: half, width: frame.width, height: half)
        }
    }

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        addSubview(firstLine)
        addSubview(secondLine)
    }
}
