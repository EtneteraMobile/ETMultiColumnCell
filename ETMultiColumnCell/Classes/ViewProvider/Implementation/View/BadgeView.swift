//
//  BadgeView.swift
//  Pods
//
//  Created by Petr Urban on 16/02/2017.
//
//

import UIKit

class BadgeView: UIView {

    // MARK: - Variables

    // MARK: Private

    private let label = UILabel()

    // MARK: Public

    override var frame: CGRect {
        didSet {

            layer.cornerRadius = min(frame.width/2, frame.height/2)
            label.frame = bounds.insetBy(dx: 2, dy: 2)
            label.center = CGPoint(x: frame.width/2, y: frame.height/2)
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

        addSubview(label)

        backgroundColor = .blue

        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
    }

    // MARK: - Customize

    func customize(text: String, backgroundColor: UIColor, textColor: UIColor) {
        label.text = text
        self.backgroundColor = backgroundColor
        label.textColor = textColor
    }
}
