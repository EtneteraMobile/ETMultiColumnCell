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

                reducedConfig = config
                reducedConfig.columns.removeLast(removeLastCount)

                // Initializes cells
                cellStatic = ETMultiColumnCell(with: config)
                cellDynamic = ETMultiColumnCell(with: reducedConfig)

                // Sets default frames
                cellStatic.frame = CGRect(origin: .zero, size: CGSize(width: 600.0, height: ETMultiColumnCell.height(with: config)))
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

                    let identifier1 = self.identifierForConfig(config)

                    expect(cellStatic.reuseIdentifier).to(equal(identifier1))

                    let identifier2 = self.identifierForConfig(reducedConfig)

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

                    // WARNING: i need to know height only based on configuration - dont know width - how to implement properly?
                    let relativeSpace = cellStatic.frame.size.width - 40.0 - 110.0 - 200.0 // Cell width minus fixed cells width
                    let relativeColumn = relativeSpace / 2.0 // Remaining space is distributed equally to relative cells
                    let layoutingString = NSAttributedString(string: "Hello there!\nwith multiline text that is too long to be layouted on one line", attributes: [ NSFontAttributeName: UIFont.systemFont(ofSize: 12) ])

                    // Calculates height manualy
                    let boundingRect1 = layoutingString.boundingRect(with: CGSize(width: relativeColumn, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

                    // Cell calculated height
                    let cellHeight1 = ETMultiColumnCell.height(with: config)

                    expect(cellHeight1).to(equal(boundingRect1.size.height))

                    // Updates cell
                    try! cellStatic.customize(with: editedConfig)

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
                    try? cellStatic.customize(with: config)
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

    private func identifierForConfig(_ config: ETMultiColumnCell.Configuration) -> String {
        
        var identifier = NSStringFromClass(ETMultiColumnCell.self) + "-"
        
        for cellConfig in config.columns {
            
            switch cellConfig.layout {
            case let .fixed(width):
                identifier += "f\(width)"
            case .relative():
                identifier += "r"
            }
        }
        
        // Builds reuse identifier
//        let uniq = config.columns.map { (cellConfig: ETMultiColumnCell.Configuration.Column) -> String in
//            
//            switch cellConfig.layout {
//            case let .fixed(width):
//                return "f\(width)"
//            case .relative():
//                return "r"
//            }
//        }
        
        return identifier
    }
    
    private func rand(withBounds: Int) -> Int {
        return Int(arc4random_uniform(UInt32(withBounds)))
    }
}
