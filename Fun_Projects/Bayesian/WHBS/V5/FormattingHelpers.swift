//
// BayesCalculator
// FormattingHelpers.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import Foundation

/// Collection of helper functions for formatting numbers and text in the app
enum FormattingHelpers {
    /// Formats a probability value as a percentage string
    /// - Parameter value: Double between 0 and 1
    /// - Returns: Formatted string with 2 decimal places and % symbol
    static func probabilityAsPercentage(_ value: Double) -> String {
        String(format: "%.2f%%", value * 100)
    }
    
    /// Formats an observation count as an integer string
    /// - Parameter value: Double representing count of observations
    /// - Returns: Formatted string with no decimal places
    static func observationCount(_ value: Double) -> String {
        String(format: "%.0f", value)
    }
    
    /// Formats a number for display in text fields
    /// - Parameter value: Double to be formatted
    /// - Returns: String suitable for text field display
    static func numberForTextField(_ value: Double) -> String {
        String(format: "%.1f", value)
    }
    
    /// Validates if a string can be converted to a valid probability value
    /// - Parameter string: String to validate
    /// - Returns: Bool indicating if string represents valid probability (0-1)
    static func isValidProbability(_ string: String) -> Bool {
        if let value = Double(string) {
            return value >= 0 && value <= 1
        }
        return false
    }
    
    /// Validates if a string can be converted to a valid observation count
    /// - Parameter string: String to validate
    /// - Returns: Bool indicating if string represents valid count (≥0)
    static func isValidObservationCount(_ string: String) -> Bool {
        if let value = Double(string) {
            return value >= 0
        }
        return false
    }
    
    /// Formats a decimal number with appropriate significant figures
    /// - Parameters:
    ///   - value: Double to format
    ///   - significantFigures: Number of significant figures to show
    /// - Returns: Formatted string
    static func formatWithSignificantFigures(_ value: Double, significantFigures: Int = 3) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = significantFigures
        formatter.minimumSignificantDigits = 1
        return formatter.string(from: NSNumber(value: value)) ?? String(value)
    }
}

// MARK: - Usage Examples
/*
 Examples of how to use these formatting helpers:
 
 // Format probability as percentage
 let probability = 0.7532
 let percentString = FormattingHelpers.probabilityAsPercentage(probability)
 // Result: "75.32%"
 
 // Format observation count
 let observations = 15.6
 let countString = FormattingHelpers.observationCount(observations)
 // Result: "16"
 
 // Format for text field
 let value = 12.34
 let textFieldString = FormattingHelpers.numberForTextField(value)
 // Result: "12.3"
 
 // Validate input
 let validProbability = FormattingHelpers.isValidProbability("0.5")  // true
 let invalidProbability = FormattingHelpers.isValidProbability("1.5") // false
 
 // Format with significant figures
 let number = 123.456789
 let formatted = FormattingHelpers.formatWithSignificantFigures(number, significantFigures: 4)
 // Result: "123.5"
 */
