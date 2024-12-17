//===------------------------------------------------===//
// BayesCalculator
// A SwiftUI application for Bayesian probability analysis
//===------------------------------------------------===//
// Version: 1.0
// Swift Version: 6.0
// Created: December 12, 2024
//
// Abstract:
// This application implements a Bayesian probability calculator
// specifically designed to solve the phone location problem.
// It uses Bayes' Theorem to calculate the probability of a phone's
// location (Bedroom vs Study) based on noise observations.
// The app provides an intuitive interface for data input and
// displays calculated probabilities including priors, likelihoods,
// and posteriors.
//===------------------------------------------------===//

import Foundation

/// Collection of helper functions for formatting numbers and text in the app
/// Provides consistent formatting across the application for probabilities,
/// observation counts, and input validation
enum FormattingHelpers {
    /// Formats a probability value as a percentage string
    /// - Parameter value: Double between 0 and 1 representing a probability
    /// - Returns: Formatted string with 2 decimal places and % symbol
    /// Example: 0.7532 -> "75.32%"
    static func probabilityAsPercentage(_ value: Double) -> String {
        String(format: "%.2f%%", value * 100)
    }
    
    /// Formats an observation count as an integer string
    /// - Parameter value: Double representing count of observations
    /// - Returns: Formatted string with no decimal places
    /// Example: 15.6 -> "16"
    static func observationCount(_ value: Double) -> String {
        String(format: "%.0f", value)
    }
    
    /// Formats a number for display in text fields
    /// - Parameter value: Double to be formatted
    /// - Returns: String suitable for text field display
    /// Example: 12.34 -> "12.3"
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

let probability = 0.7532
let percentString = FormattingHelpers.probabilityAsPercentage(probability)
// Result: "75.32%"

let observations = 15.6
let countString = FormattingHelpers.observationCount(observations)
// Result: "16"

let value = 12.34
let textFieldString = FormattingHelpers.numberForTextField(value)
// Result: "12.3"

let validProbability = FormattingHelpers.isValidProbability("0.5")  // true
let invalidProbability = FormattingHelpers.isValidProbability("1.5") // false

let number = 123.456789
let formatted = FormattingHelpers.formatWithSignificantFigures(number, significantFigures: 4)
// Result: "123.5"
*/
