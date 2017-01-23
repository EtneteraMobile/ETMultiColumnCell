// https://github.com/Quick/Quick

import Quick
import Nimble
import ETMultiColumnCell

class MutliColumnCellSpec: QuickSpec {
    override func spec() {

        describe("multiColumnCell") {

            // Contains static number of columns.
            var cellStatic: ETMultiColumnCell!

            // Contains dynamic number of columns (based on random number from beforeEach).
            var cellDynamic: ETMultiColumnCell!

            // Basic configuration.
            var config: Configuration!

            // Edited basic configuration for height calculations.
            var editedConfig: Configuration!

            // Basic configuration with removed random number of columns from tail.
            var reducedConfig: Configuration!

            beforeEach {

                // Creates basic configuration
                config = Configuration(columns: [
                    ColumnCofiguration(layout: .fixed(40.0), text: "Hello there!"),
                    ColumnCofiguration(layout: .relative, text: "Hello there!\nwith multiline text that is too long to be layouted on one line"),
                    ColumnCofiguration(layout: .fixed(110.0), text: "Hello there!"),
                    ColumnCofiguration(layout: .fixed(200.0), text: "Hello there!"),
                    ColumnCofiguration(layout: .relative, text: "Hello there!")
                    ])

                // Creates edited basic configuration
                editedConfig = Configuration(columns: [
                    ColumnCofiguration(layout: .fixed(40.0), text: "Hello there! With multiline text that is too long to be layouted on one line"),
                    ColumnCofiguration(layout: .relative, text: "Hi!"),
                    ColumnCofiguration(layout: .fixed(110.0), text: "Hello there!"),
                    ColumnCofiguration(layout: .fixed(200.0), text: "Hello there!"),
                    ColumnCofiguration(layout: .relative, text: "Hello there!")
                    ])

                // - 1 to at least one element will exist
                // + 1 to at least one element will be removed
                let removeLastCount = config.columns.count - Int(arc4random_uniform(config.columns.count - 1) + 1)

                // Creates configuration with dynamic number of columns
                reducedConfig = Configuration(columns: config.columns.removeLast(removeLastCount))

                // Initializes cells
                cellStatic = ETMultiColumnCell(with: config)
                cellDynamic = ETMultiColumnCell(with: reducedConfig)

                // Sets default frames
                cellStatic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))
                cellDynamic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: 44.0))
            }

            context("cellForRow") {

                it("with right type") {

                    expect(cellStatic).to(be(ETMultiColumnCell.self))
                    expect(cellDynamic).to(be(ETMultiColumnCell.self))
                }

                it("with right number of subviews") {

                    // Default config
                    expect(cellStatic.contentView.subviews).to(equal(config.columns.count))

                    // Reduced config (dynamic number of columns)
                    expect(cellDynamic.contentView.subviews).to(equal(reducedConfig.columns.count))
                }

                it("with right reuse identifier") {

                    let identifier1 = identifierForConfig(config)

                    expect(cellStatic.reuseIdentifier).to(equal(identifier1))

                    let identifier2 = identifierForConfig(reducedConfig)

                    expect(cellDynamic.reuseIdentifier).to(equal(identifier2))
                }

            }

            context("willDisplayCell") {

                it("customize(with:)") {

                    let subviews = cellStatic.contentView.subviews as! [UILabel]

                    // Prepares cell
                    cellStatic.customize(with: config)

                    expect(subviews[0].text).to(equal("Hello there!"))
                    expect(subviews[1].text).to(equal("Hello there!\nwith multiline text that is too long to be layouted on one line"))

                    // Customizes with new content
                    cellStatic.customize(with: editedConfig)

                    expect(subviews[0].text).to(equal("Hello there!\nwith multiline text that is too long to be layouted on one line"))
                    expect(subviews[1].text).to(equal("Hi!"))
                }

                context("errors") {

                    it("column count missmatch") {

                        expect{ try cellStatic.customize(with: reducedConfig) }.to(throwError())
                        expect{ try cellDynamic.customize(with: config) }.to(throwError())
                    }

//                    it("TODO") {
//
//                    }
                }
            }


            context("height") {

                it("static height(with:)") {

                    let relativeSpace = cellStatic.frame.size.width - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                    let relativeColumn = relativeSpace / 2.0 // Remaining space is distributed equally to relative cells
                    let layoutingString = NSAttributedString(string: "Hello there!\nwith multiline text that is too long to be layouted on one line", attributes: [ NSFontAttributeName: UIFont.systemFont(ofSize: 12) ])

                    // Calculates height manualy
                    let boundingRect1 = layoutingString.boundingRect(with: CGSize(width: relativeColumn, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                    // Cell calculated height
                    let cellHeight1 = ETMultiColumnCell.height(with: config)

                    expect(cellHeight1).to(equal(boundingRect1.size.height))

                    // Updates cell
                    cellStatic.customize(with: editedConfig)

                    // Calculates height manualy
                    let boundingRect2 = layoutingString.boundingRect(with: CGSize(width: 40.0, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                    // Cell calculated height
                    let cellHeight2 = ETMultiColumnCell.height(with: config)

                    expect(cellHeight2).to(equal(boundingRect2.size.height))
                }

                it("layoutSubviews") {

                    // Calculast height according config
                    let cellHeight1 = ETMultiColumnCell.height(with: config)
                    let cellHeight2 = ETMultiColumnCell.height(with: editedConfig)

                    // Customizes cell and layouts it
                    cellStatic.customize(with: config)
                    cellStatic.layoutSubviews()

                    expect(cellStatic.height).to(equal(cellHeight1))

                    // Updates cell
                    cellStatic.customize(with: editedConfig)
                    cellStatic.layoutSubviews()

                    expect(cellStatic.height).to(equal(cellHeight2))

                }

                context("errors") {

                    it("column count missmatch") {

                        expect{ try cellStatic.height(with: reducedConfig) }.to(throwError())
                        expect{ try cellDynamic.height(with: config) }.to(throwError())
                    }

//                    it("TODO") {
//
//                    }
                }
            }

        }
    }

    private func identifierForConfig(_ config: Configuration) -> String {

        // Builds reuse identifier
        let uniq = config.columns.map {
            if case let .fixed(width) = $0.layout {
                return "f\(width)"
            }
            else {
                return "r"
            }
        }
        let identifier = NSStringFromClass(ETMultiColumnCell) + "-" + uniq
    }
}
