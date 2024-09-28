//
// MathStuffV1
// MathStuffV1Tests.swift
//
// Created on 9/23/24
// Revised on 9/28/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//   Tutor: Anthropic's AI Claude
//

/*
Abstract:
This file contains unit tests for the MathStuffOperations class defined in MathStuffOp.swift.
It includes test cases for the addition and subtraction functions to ensure they produce correct results.
These tests serve as examples of how to write and structure unit tests in Swift.
*/

/// Importing the Testing framework for unit testing capabilities
import Testing

/// Importing the MathStuffV1 module, making it available for testing
@testable import MathStuffV1

/// Test suite for MathStuffV1 operations
struct MathStuffV1Tests {
    
    /// Test case for the text() function in MathStuffOperations
    ///
    /// This test verifies that the text() function returns the expected greeting.
    @Test("Hello World Test")
    func testText() throws {
        // Create an instance of MathStuffOperations
        let mathOperations = MathStuffOperations()
        
        // Assert that the text() function returns "Hello, World!"
        #expect(mathOperations.text() == "Hello, World!")
    }
    
    /// Test case for the addNumbers(_:_:) function in MathStuffOperations
    ///
    /// This test checks if the addNumbers function correctly adds two integers.
    @Test("Add Numbers Test")
    func testAddNumbers() throws {
        // Create an instance of MathStuffOperations
        let mathOperations = MathStuffOperations()
        
        // Assert that adding 1 and 2 results in 3
        #expect(mathOperations.addNumbers(1, 2) == 3)
    }
    
    /// Tests the subtractNumbers function
    @Test("Subtract Numbers Test")
    func testSubNumbers() async throws {
        // Create an instance of MathStuffOperations
        let mathOperations = MathStuffOperations()
        // Assert that subtracting 3 and 2 results in 1
        #expect(mathOperations.subtractNumbers(3, 2) == 1)
    }
}

//import XCTest
//@testable import MathStuffV1
//
///// Test case class for MathStuffOperations
//class MathStuffOperationsTests: XCTestCase {
//    
//    /// Tests the addNumbers function
//    func testAddNumbers() {
//        // Create an instance of MathStuffOperations
//        let math = MathStuffOperations()
//        
//        // Call the addNumbers function with test inputs
//        let result = math.addNumbers(1, 2)
//        
//        // Assert that the result is equal to the expected output
//        XCTAssertEqual(result, 3)
//        // Test succeeded
//    }
//    
//    /// Tests the subtractNumbers function
//    func testSubNumbers() {
//        // Create an instance of MathStuffOperations
//        let math = MathStuffOperations()
//        
//        // Call the subtractNumbers function with test inputs
//        let result = math.subtractNumbers(4, 2)
//        
//        // Assert that the result is equal to the expected output
//        XCTAssertEqual(result, 2)
//        // Test succeeded
//    }
//}
