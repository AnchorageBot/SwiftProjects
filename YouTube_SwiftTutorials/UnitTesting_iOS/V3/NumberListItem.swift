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

/*
Abstract:

This file defines the NumberListItem class, which represents a single item
in the list of saved number pairs. It uses SwiftData for persistence and
includes properties for the numbers, their sum, and their classifications.

Key components:
- SwiftData model for number pairs
- Properties for numbers and their sum
- Computed properties for number classifications
*/

import Foundation
import SwiftData

/// Represents a single item in the number list
@Model
class NumberListItem {
    
    // MARK: - Properties
    
    /// The first number in the pair
    let number1: Int
    
    /// The second number in the pair
    let number2: Int
    
    /// The sum of the two numbers
    let sum: Int
    
    /// The date when the item was created or last modified
    let date: Date
    
    // MARK: - Computed Properties
    
    /// The main title of the number item (e.g., "5 and 7")
    var title: String {
        return "\(number1) and \(number2)"
    }
    
    /// Additional information about the number item (e.g., "Sum: 12")
    var subtitle: String {
        return "Sum: \(sum)"
    }
    
    /// Classification of the first number (odd, even, prime)
    var classification1: String {
        return NumberUtils.propertiesToString(NumberUtils.classifyNumber(number1))
    }
    
    /// Classification of the second number (odd, even, prime)
    var classification2: String {
        return NumberUtils.propertiesToString(NumberUtils.classifyNumber(number2))
    }
    
    // MARK: - Initializer
    
    init(number1: Int, number2: Int, sum: Int, date: Date = Date()) {
        self.number1 = number1
        self.number2 = number2
        self.sum = sum
        self.date = date
    }
}
