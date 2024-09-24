//
// MathStuffV1
// MathStuffV1Tests.swift
//
// Created on 9/23/24
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
    
}


//import Testing

//struct MathStuffV1Tests {
//    
//    @Test func testAdd() async throws {
//
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//        
//        #expect(addNumbers(1, 2) == 3)
//        
//    }
//
//}
