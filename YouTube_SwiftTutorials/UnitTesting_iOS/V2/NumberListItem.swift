//
// BasicMath
// NumberListItem.swift
//
// Created on 9/15/24
// Updated on 9/15/24
// Swift Version 5.0+
//
// ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

import Foundation
import SwiftData

/// Represents a single item in the number list
@Model
class NumberListItem {
    
    // MARK: - Properties
    
    /// The main title of the number item (e.g., "5 and 7")
    let title: String
    
    /// Additional information about the number item (e.g., "Sum: 12")
    let subtitle: String
    
    /// The date when the item was created or last modified
    let date: Date
    
    /// The first number in the pair
    let number1: Int
    
    /// The second number in the pair
    let number2: Int
    
    /// Classification of the first number (odd, even, prime)
    let classification1: String
    
    /// Classification of the second number (odd, even, prime)
    let classification2: String
    
    // MARK: - Initializer
    
    init(title: String, subtitle: String, date: Date) {
        // Extract numbers from the title
        let numbers = title.components(separatedBy: " and ").compactMap { Int($0) }
        let num1 = numbers.first ?? 0
        let num2 = numbers.last ?? 0
        
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.number1 = num1
        self.number2 = num2
        self.classification1 = NumberListItem.classifyNumber(num1)
        self.classification2 = NumberListItem.classifyNumber(num2)
    }
    
    // MARK: - Helper Methods
    
    /// Classifies a number as odd, even, and/or prime
    /// - Parameter number: The number to classify
    /// - Returns: A string describing the number's properties
    private static func classifyNumber(_ number: Int) -> String {
        var properties: [String] = []
        if number % 2 != 0 { properties.append("odd") }
        if number % 2 == 0 { properties.append("even") }
        if isPrime(number) { properties.append("prime") }
        return properties.joined(separator: ", ")
    }
    
    /// Checks if a number is prime
    /// - Parameter number: The number to check
    /// - Returns: True if the number is prime, false otherwise
    private static func isPrime(_ number: Int) -> Bool {
        guard number > 1 else { return false }
        for i in 2..<Int(Double(number).squareRoot()) + 1 {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}
