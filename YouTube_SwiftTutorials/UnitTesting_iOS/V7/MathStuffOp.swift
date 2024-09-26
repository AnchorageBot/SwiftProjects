//
// MathStuffV1
// MathStuffOp.swift
//
// Created on 9/23/24
// Revised on 9/25/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//   Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file defines a MathStuffOperations class that provides basic mathematical operations.
It includes two simple functions for addition and subtraction of integers.
These functions are intended to be used as examples for unit testing in the MathStuffV1Tests.swift file.
*/

import Foundation

/// A class that provides basic mathematical operations
public class MathStuffOperations {
    
    /// Adds two integers and returns the result
    /// - Parameters:
    ///   - a: The first integer to add
    ///   - b: The second integer to add
    /// - Returns: The sum of the two input integers
    func addNumbers(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    /// Subtracts the second integer from the first and returns the result
    /// - Parameters:
    ///   - a: The integer to subtract from
    ///   - b: The integer to subtract
    /// - Returns: The difference between the two input integers
    func subtractNumbers(_ a: Int, _ b: Int) -> Int {
        return a - b
    }
}
