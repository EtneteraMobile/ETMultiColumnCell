//
//  Configuration.swift
//  Pods
//
//  Created by Petr Urban on 24/01/2017.
//
//

import Foundation

// MARK: - Cell configuration

public extension ETMultiColumnCell {
    
    /// ETMultiColumnCell configuration structure
    public struct Configuration {
        
        // MARK: - Variables
        
        /// array of configuration for each column
        public var columns: [Column]
        
        // MARK: - Initialization
        
        /// Constor for cell configuration
        ///
        /// - Parameter columns: array of configuration for each column
        public init(columns: [Column]) {
            self.columns = columns
        }
        
        // MARK: - Actions
        
        /// Returns hash for cell layout configuration
        ///
        /// - Returns: unique hash for layout configuration
        public func layoutHash() -> String {
            
            var configHash = ""
            
            for config in self.columns {
                
                switch config.layout {
                case let .fixed(width):
                    configHash += "f\(width)"
                case .relative():
                    configHash += "r"
                }
            }
            
            return configHash
        }
        
        // MARK: Column configuration
        
        
        /// Column configuration structure of ETMultiColumnCell
        public struct Column {
            
            // MARK: - Variables
            
            public let layout: Layout
            public let text: String
            
            // MARK: - Initialization
            
            public init(layout: Layout, text: String) {
                self.layout = layout
                self.text = text
            }
            
            // MARK: - Properties
            
            /// Layout properties
            ///
            /// - relative: relative size column
            /// - fixed: fixed size column (size as parameter)
            public enum Layout {
                case relative
                case fixed(CGFloat)
            }
        }
    }
}
