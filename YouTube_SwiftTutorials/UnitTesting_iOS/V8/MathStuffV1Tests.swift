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

import Testing
@testable import MathStuffV1

struct MathStuffV1Tests {
    
    @Test
    func testText() throws {
        let mathOperations = MathStuffOperations()
        #expect(mathOperations.text() == "Hello, World!")
    }
    
    @Test
    func testAddNumbers() throws {
        let mathOperations = MathStuffOperations()
        #expect(mathOperations.addNumbers(1, 2) == 3)
    }

    @Test("Subtract Numbers Test")
    func testSubNumbers() async throws {
        let mathOperations = MathStuffOperations()
        #expect(mathOperations.subtractNumbers(3, 2) == 1)
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
