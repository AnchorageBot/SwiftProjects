//
// MathStuffV1
// MathStuffV1Tests.swift
//
// Created on 9/23/24
// Revised on 9/24/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//


import XCTest
@testable import MathStuffV1


class MathStuffOperationsTests: XCTestCase {
    
    func testAddNumbers() {
        
        let math = MathStuffOperations()
        let result = math.addNumbers(1, 2)
        
        XCTAssertEqual(result, 3)
        // Test succeeded
    }
    
    func testSubNumbers() {
        
        let math = MathStuffOperations()
        let result = math.subtractNumbers(4, 2)
        
        XCTAssertEqual(result, 2)
         //Test
    }
    
}
