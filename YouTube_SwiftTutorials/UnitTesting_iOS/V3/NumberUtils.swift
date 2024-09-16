//
// BasicMath
// NumberUtils.swift
//
// Created on 9/15/24
// Updated on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//

/*
Abstract:

This file contains utility functions for number operations and classifications.
It serves as a central location for shared mathematical logic used throughout the app.

Key components:
- Number property checking (odd, even, prime)
- Number classification
*/

import Foundation

/// Enumeration representing the possible properties of a number
public enum NumberProperty: String, CaseIterable {
    case odd, even, prime
}

/// A structure containing utility functions for number operations
public struct NumberUtils {
    
    /// Checks if a number is odd
    /// - Parameter number: The number to check
    /// - Returns: True if the number is odd, false otherwise
    public static func isOdd(_ number: Int) -> Bool {
        return number % 2 != 0
    }
    
    /// Checks if a number is even
    /// - Parameter number: The number to check
    /// - Returns: True if the number is even, false otherwise
    public static func isEven(_ number: Int) -> Bool {
        return number % 2 == 0
    }
    
    /// Checks if a number is prime
    /// - Parameter number: The number to check
    /// - Returns: True if the number is prime, false otherwise
    public static func isPrime(_ number: Int) -> Bool {
        guard number > 1 else { return false }
        for i in 2..<Int(Double(number).squareRoot()) + 1 {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
    
    /// Classifies a number based on its properties (odd, even, prime)
    /// - Parameter number: The number to classify
    /// - Returns: An array of NumberProperty enums representing the number's properties
    public static func classifyNumber(_ number: Int) -> [NumberProperty] {
        var properties: [NumberProperty] = []
        if isOdd(number) { properties.append(.odd) }
        if isEven(number) { properties.append(.even) }
        if isPrime(number) { properties.append(.prime) }
        return properties
    }
    
    /// Converts an array of NumberProperty enums to a comma-separated string
    /// - Parameter properties: Array of NumberProperty enums
    /// - Returns: A string representation of the number's properties
    public static func propertiesToString(_ properties: [NumberProperty]) -> String {
        return properties.map { $0.rawValue }.joined(separator: ", ")
    }
}
