// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ETMultiColumnCell

class MutliColumnCellSpec: QuickSpec {
    override func spec() {

        // FIXME: Missing implementation
        // * Separator (width, color) border tests

        describe("multiColumnCell") {

            // Contains static number of columns.
            var cellStatic: ETMultiColumnCell!

            // Contains dynamic number of columns (based on random number from beforeEach).
            var cellDynamic: ETMultiColumnCell!

            // Basic configuration.
            var config: ETMultiColumnCell.Configuration!

            // Config with borders (separators).
            var configWithBorders: ETMultiColumnCell.Configuration!

            // Config with non zero edges.
            var configWithNonZeroEdges: ETMultiColumnCell.Configuration!

            // Config with non zero edges.
            var configWithBigEdges: ETMultiColumnCell.Configuration!

            // Edited basic configuration for height calculations.
            var editedConfig: ETMultiColumnCell.Configuration!

            // Basic configuration with removed random number of columns from tail.
            var reducedConfig: ETMultiColumnCell.Configuration!

            beforeEach {
                
                // Creates basic configuration
                config = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
                    ])

                // Creates configuration with borders
                configWithBorders = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(border: .left(width: 1, color: .black)), text: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0, border: .left(width: 1, color: .black)), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0, border: .left(width: 1, color: .black)), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
                    ])

                // Creates configuration with edges
                configWithNonZeroEdges = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
                    ])

                // Creates configuration with non to big edges
                configWithBigEdges = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, edges: .inner(top: 15, left: 10, bottom: 15, right: 100)), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(edges: .inner(top: 15, left: 10, bottom: 15, right: 10)), text: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
                    ])

                // Creates edited basic configuration
                editedConfig = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0), text: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hi!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(), text: "Hello there!")
                    ])

                // - 1 to at least one element will exist
                // + 1 to at least one element will be removed
                let randCountToRemove = config.columns.count - self.rand(withBounds: config.columns.count - 1)
                let removeLastCount = randCountToRemove == 0 ? 1 : randCountToRemove

                var columns = config.columns
                columns.removeLast(removeLastCount)
                reducedConfig = ETMultiColumnCell.Configuration(columns: columns)

                // Initializes cells
                cellStatic = ETMultiColumnCell(with: config)
                cellDynamic = ETMultiColumnCell(with: reducedConfig)

                // Sets default frames
                cellStatic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))
                cellStatic.contentView.frame = cellStatic.bounds
                cellDynamic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))
                cellDynamic.contentView.frame = cellDynamic.bounds
            }

            context("cellForRow") {

                it("with right type") {

                    expect(cellStatic).to(beAnInstanceOf(ETMultiColumnCell.self))
                    expect(cellDynamic).to(beAnInstanceOf(ETMultiColumnCell.self))
                }

                it("with right number of subviews") {

                    // Default config
                    expect(cellStatic.contentView.subviews.count).to(equal(config.columns.count))

                    // Reduced config (dynamic number of columns)
                    expect(cellDynamic.contentView.subviews.count).to(equal(reducedConfig.columns.count))
                }

                it("with right reuse identifier") {

                    let identifier1 = "\(NSStringFromClass(ETMultiColumnCell.self))-\(config.columns.count)"
                    expect(cellStatic.reuseIdentifier).to(equal(identifier1))

                    let identifier2 = "\(NSStringFromClass(ETMultiColumnCell.self))-\(reducedConfig.columns.count)"
                    expect(cellDynamic.reuseIdentifier).to(equal(identifier2))
                }

            }

            context("willDisplayCell") {

                context("content") {

                    it("customize(with:)") {

                        let subviews = cellStatic.contentView.subviews as! [UILabel]

                        // Prepares cell
                        try! cellStatic.customize(with: config)

                        expect(subviews[0].text).to(equal("Hello there!"))
                        expect(subviews[1].attributedText).to(equal(self.attributedText))

                        // Customizes with new content
                        try? cellStatic.customize(with: editedConfig)

                        expect(subviews[0].attributedText).to(equal(self.attributedText))
                        expect(subviews[1].text).to(equal("Hi!"))
                    }
                }

                context("label position") {

                    it("customize(with:)") {

                        cellStatic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))

                        // Updates cell
                        try! cellStatic.customize(with: configWithNonZeroEdges)

                        let subviews = cellStatic.contentView.subviews

                        let relativeSpace = cellStatic.frame.width - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                        let relativeColumn = floor(relativeSpace / 2.0) // Remaining space is distributed equally to relative cells

                        expect(subviews[0].frame.width).to(equal(20))
                        expect(subviews[0].frame.origin.x).to(equal(10))

                        expect(subviews[1].frame.width).to(equal(relativeColumn - 10 - 10))
                        expect(subviews[1].frame.origin.x).to(equal(40 + 10))

                        expect(subviews[2].frame.width).to(equal(110))
                        expect(subviews[2].frame.origin.x).to(equal(40 + relativeColumn))

                        expect(subviews[3].frame.width).to(equal(200))
                        expect(subviews[3].frame.origin.x).to(equal(40 + relativeColumn + 110))

                        expect(subviews[4].frame.width).to(equal(relativeColumn))
                        expect(subviews[4].frame.origin.x).to(equal(40 + relativeColumn + 110 + 200))
                    }
                }

                context("border") {

                    it("customize(with:)") {
                        cellStatic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))

                        let cellHeight = try! ETMultiColumnCell.height(with: editedConfig, width: cellStatic.frame.width)

                        // Updates cell
                        try! cellStatic.customize(with: configWithBorders)

                        let calcPath = UIBezierPath()

                        calcPath.move(to: CGPoint(x: 40, y: 0))
                        calcPath.addLine(to: CGPoint(x: 40, y: cellHeight))

                        calcPath.move(to: CGPoint(x: 110, y: 0))
                        calcPath.addLine(to: CGPoint(x: 110, y: cellHeight))

                        calcPath.move(to: CGPoint(x: 200, y: 0))
                        calcPath.addLine(to: CGPoint(x: 200, y: cellHeight))

                        calcPath.lineWidth = 1

                        let calcLayer = CAShapeLayer()
                        calcLayer.fillColor = nil
                        calcLayer.strokeColor = UIColor.black.cgColor
                        calcLayer.path = calcPath.cgPath

                        let borderLayers = cellStatic.layer.sublayers![1].sublayers as! [CAShapeLayer]

                        expect(borderLayers.count).to(equal(configWithBorders.columns.count))

                        // FIXME: write test - paths equals
                    }
                }

                context("errors") {

                    it("column count missmatch") {

                        let description1 = "expected: \(config.columns.count) columns, got: \(reducedConfig.columns.count) columns"
                        let description2 = "expected: \(reducedConfig.columns.count) columns, got: \(config.columns.count) columns"

                        expect{ try cellStatic.customize(with: reducedConfig) }.to(throwError(ETMultiColumnCell.Error.columnsCountMissmatch(description: description1)))
                        expect{ try cellDynamic.customize(with: config) }.to(throwError(ETMultiColumnCell.Error.columnsCountMissmatch(description: description2)))
                    }

                    it("invalid width") {

                        cellStatic.frame.size.width = 0.0
                        expect{ try cellStatic.customize(with: config) }.to(throwError(ETMultiColumnCell.Error.invalidWidth()))
                    }

                    it("insufficient width") {

                        cellStatic.frame.size.width = 200.0
                        let error = "Sum width of fixed colums is longer than column width (fixedColumnsWidthSum=350.0, columnWidth=200.0)."
                        expect{ try cellStatic.customize(with: config) }.to(throwError(ETMultiColumnCell.Error.insufficientWidth(description: error)))
                    }

                    it("insufficient width - big edges") {

                        cellStatic.frame.size.width = 200.0
                        let error = "Horizontal edges are longer than cell width (horizontalEdges=110.0, columnWidth=40.0)."
                        expect{ try cellStatic.customize(with: configWithBigEdges) }.to(throwError(ETMultiColumnCell.Error.insufficientWidth(description: error)))
                    }
                }
            }

            context("height") {

                context("zero edges") {

                    it("static height(with:width:)") {

                        let cellWidth = cellStatic.frame.size.width
                        let relativeSpace = cellWidth - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                        let relativeColumn = floor(relativeSpace / 2.0) // Remaining space is distributed equally to relative cells
                        let layoutingString = self.attributedText

                        // Calculates height manualy
                        let boundingRect1 = layoutingString.boundingRect(with: CGSize(width: relativeColumn, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                        // Cell calculated height
                        let cellHeight1 = try! ETMultiColumnCell.height(with: config, width: cellWidth)

                        expect(cellHeight1).to(equal(ceil(boundingRect1.size.height)))

                        // Updates cell
                        try! cellStatic.customize(with: editedConfig)

                        // Calculates height manualy
                        let boundingRect2 = layoutingString.boundingRect(with: CGSize(width: 40.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                        // Cell calculated height
                        let cellHeight2 = try! ETMultiColumnCell.height(with: editedConfig, width: cellWidth)

                        expect(cellHeight2).to(equal(ceil(boundingRect2.size.height)))
                    }
                }

                context("non zero edges") {

                    it("static height(with:width:)") {

                        let cellWidth = cellStatic.frame.size.width
                        let relativeSpace = cellWidth - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                        let relativeColumn = floor(relativeSpace / 2.0) // Remaining space is distributed equally to relative cells
                        let edgesHorizontal = CGFloat(10 + 10) // left + right
                        let edgesVertical = CGFloat(15 + 15)
                        let columnContentWidth = relativeColumn - edgesHorizontal // Remaining space minus left right edges
                        let layoutingString = self.attributedText

                        // Calculates height manualy
                        let boundingRect1 = layoutingString.boundingRect(with: CGSize(width: columnContentWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                        // Cell calculated height
                        let cellHeight1 = try! ETMultiColumnCell.height(with: configWithNonZeroEdges, width: cellWidth)

                        expect(cellHeight1).to(equal(ceil(boundingRect1.size.height + edgesVertical)))

                        // Updates cell
                        try! cellStatic.customize(with: editedConfig)

                        // Calculates height manualy
                        let boundingRect2 = layoutingString.boundingRect(with: CGSize(width: 40.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                        // Cell calculated height
                        let cellHeight2 = try! ETMultiColumnCell.height(with: editedConfig, width: cellWidth)
                        
                        expect(cellHeight2).to(equal(ceil(boundingRect2.size.height)))
                    }

                    context("errors") {
                        it("insufficient width") {
                            let cellWidth = cellStatic.frame.size.width

                            // Cell calculated height
                            let error = "Horizontal edges are longer than cell width (horizontalEdges=110.0, columnWidth=40.0)."
                            expect{ try ETMultiColumnCell.height(with: configWithBigEdges, width: cellWidth) }.to(throwError(ETMultiColumnCell.Error.insufficientWidth(description: error)))
                        }
                    }
                }
            }

            context("columns width") {

                it("static width") {

                    // Static number of columns

                    let relativeColumnWidth = floor((cellStatic.contentView.frame.size.width - 40.0 - 110.0 - 200.0)/2.0)
                    let expectedColumnsWidth = [ 40.0, relativeColumnWidth, 110.0, 200.0, relativeColumnWidth ]

                    try! cellStatic.customize(with: config)

                    let result = cellStatic.contentView.subviews.map { $0.frame.size.width }

                    expect(result).to(equal(expectedColumnsWidth))

                    // Dynamic number of columns

                    var columnsWidth:[CGFloat] = [ 40.0, 0.0, 110.0, 200.0, 0.0 ]
                    columnsWidth.removeLast(config.columns.count - reducedConfig.columns.count)
                    let relativeColumnWidth2 = (cellStatic.contentView.frame.size.width - columnsWidth.reduce(CGFloat(0.0)) { $0 + $1 })

                    var expectedColumnsWidth2 = [ 40.0, relativeColumnWidth2, 110.0, 200.0, relativeColumnWidth2 ]
                    expectedColumnsWidth2.removeLast(config.columns.count - reducedConfig.columns.count)

                    try! cellDynamic.customize(with: reducedConfig)

                    let result2 = cellDynamic.contentView.subviews.map { $0.frame.size.width }

                    expect(result2).to(equal(expectedColumnsWidth2))
                }

                it("dynamic width") {

                    // Width with initial size
                    var width = cellStatic.contentView.frame.size.width

                    var relativeColumnWidth = floor((width - 40.0 - 110.0 - 200.0)/2.0)
                    var expectedColumnsWidth = [ 40.0, relativeColumnWidth, 110.0, 200.0, relativeColumnWidth ]

                    try! cellStatic.customize(with: config)

                    var result = cellStatic.contentView.subviews.map { $0.frame.size.width }

                    expect(result).to(equal(expectedColumnsWidth))

                    // Increased width of cellStatic
                    width = 1200.0
                    var frame = cellStatic.frame
                    frame.size.width = width
                    cellStatic.frame = frame
                    cellStatic.contentView.frame = cellStatic.bounds

                    relativeColumnWidth = floor((width - 40.0 - 110.0 - 200.0)/2.0)
                    expectedColumnsWidth = [ 40.0, relativeColumnWidth, 110.0, 200.0, relativeColumnWidth ]

                    try! cellStatic.customize(with: config)

                    result = cellStatic.contentView.subviews.map { $0.frame.size.width }

                    expect(result).to(equal(expectedColumnsWidth))

                    // Decreased width of cell
                    width = 400.0
                    frame = cellStatic.frame
                    frame.size.width = width
                    cellStatic.frame = frame
                    cellStatic.contentView.frame = cellStatic.bounds

                    relativeColumnWidth = floor((width - 40.0 - 110.0 - 200.0)/2.0)
                    expectedColumnsWidth = [ 40.0, relativeColumnWidth, 110.0, 200.0, relativeColumnWidth ]

                    try! cellStatic.customize(with: config)

                    result = cellStatic.contentView.subviews.map { $0.frame.size.width }

                    expect(result).to(equal(expectedColumnsWidth))
                }
            }
        }
    }

    private func rand(withBounds: Int) -> Int {
        return Int(arc4random_uniform(UInt32(withBounds)))
    }

    private var attributedText: NSAttributedString {

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
