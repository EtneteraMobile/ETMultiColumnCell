// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import ETMultiColumnCell

class MutliColumnCellSpec: QuickSpec {
    override func spec() {

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
                
                config = ETMultiColumnCell.Configuration(columns: [ETMultiColumnCell.Configuration.Column(layout: .relative, text: "asdasd")])
                
                // Creates basic configuration
                config = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(40.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative, text: "Hello there!\nwith multiline text that is too long to be layouted on one line"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative, text: "Hello there!")
                    ])

                // Creates edited basic configuration
                editedConfig = ETMultiColumnCell.Configuration(columns: [
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(40.0), text: "Hello there! With multiline text that is too long to be layouted on one line"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative, text: "Hi!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(110.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .fixed(200.0), text: "Hello there!"),
                    ETMultiColumnCell.Configuration.Column(layout: .relative, text: "Hello there!")
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
                cellDynamic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))
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
                    expect(subviews[1].text).to(equal("Hello there!\nwith multiline text that is too long to be layouted on one line"))

                    // Customizes with new content
                    try? cellStatic.customize(with: editedConfig)

                    expect(subviews[0].text).to(equal("Hello there! With multiline text that is too long to be layouted on one line"))
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
                    let layoutingString = NSAttributedString(string: "Hello there!\nwith multiline text that is too long to be layouted on one line", attributes: [ NSFontAttributeName: UIFont.systemFont(ofSize: 12) ])

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

            }
        }
    }

    private func identifierForConfig(_ config: ETMultiColumnCell.Configuration) -> String {
        
        return config.columns.reduce(NSStringFromClass(ETMultiColumnCell.self) + "-") { result, current in

            switch current.layout {
            case let .fixed(width):
                return result + "f\(width)"
            case .relative():
                return result + "r"
            }
        }
    }
    
    private func rand(withBounds: Int) -> Int {
        return Int(arc4random_uniform(UInt32(withBounds)))
    }
}
