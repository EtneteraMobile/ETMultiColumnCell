// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ETMultiColumnCell

class MutliColumnCellSpec: QuickSpec {
    override func spec() {

        // FIXME: Missing implementation
        // * Attributed string as text
        // * Padding inside of column
        // * Space between columns
        // * Separator (width, color)

        describe("multiColumnCell") {

            // Contains static number of columns.
            var cellStatic: ETMultiColumnCell!

            // Contains dynamic number of columns (based on random number from beforeEach).
            var cellDynamic: ETMultiColumnCell!

            // Basic configuration.
            var config: ETMultiColumnCell.Configuration!

            // Edited basic configuration for height calculations.
            var editedConfig: ETMultiColumnCell.Configuration!

            // Basic configuration with removed random number of columns from tail.
            var reducedConfig: ETMultiColumnCell.Configuration!

            beforeEach {
                
                // Creates basic configuration
                config = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, inner: nil), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(inner: nil), attText: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0, inner: nil), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0, inner: nil), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(inner: nil), text: "Hello there!")
                    ])

                // Creates edited basic configuration
                editedConfig = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 40.0, inner: nil), attText: self.attributedText),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(inner: nil), text: "Hi!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 110.0, inner: nil), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(width: 200.0, inner: nil), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative(inner: nil), text: "Hello there!")
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
                        expect{ try cellStatic.customize(with: config) }.to(throwError(ETMultiColumnCell.Error.insufficientWidth()))
                    }
                }
            }

            context("height") {

                it("static height(with:width:)") {

                    let cellWidth = cellStatic.frame.size.width
                    let relativeSpace = cellWidth - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                    let relativeColumn = floor(relativeSpace / 2.0) // Remaining space is distributed equally to relative cells
                    let layoutingString = self.attributedText

                    // Calculates height manualy
                    let boundingRect1 = layoutingString.boundingRect(with: CGSize(width: relativeColumn, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                    // Cell calculated height
                    let cellHeight1 = ETMultiColumnCell.height(with: config, width: cellWidth)

                    expect(cellHeight1).to(equal(ceil(boundingRect1.size.height)))

                    // Updates cell
                    try! cellStatic.customize(with: editedConfig)

                    // Calculates height manualy
                    let boundingRect2 = layoutingString.boundingRect(with: CGSize(width: 40.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                    // Cell calculated height
                    let cellHeight2 = ETMultiColumnCell.height(with: editedConfig, width: cellWidth)

                    expect(cellHeight2).to(equal(ceil(boundingRect2.size.height)))
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
