//
//  GroceryListItemTests.swift
//  GroceryListV6
//
//  Created on 9/13/24
//  Swift Version 5.0
//
//  ATS Project
//  Tutor: Anthropic's AI Claude
//  Tutor: Afraz Siddiqui - iOS Academy YouTube
//

/*
Abstract:
This file contains tests for the GroceryListItem model using the Swift Testing framework.
It demonstrates how to write and run simple tests for the GroceryListItem's updatePrice method.

Key components:
- Import of the Swift Testing framework
- Test case for updating the price of a GroceryListItem
- Assertions to verify the correct behavior of the updatePrice method
*/
//
//import Foundation
//import SwiftData
//@testable import GroceryListV6
//
//#if canImport(XCTest)
//import XCTest
//
//final class GroceryListItemTests: XCTestCase {
//    
//    func testUpdatePrice() throws {
//        let item = GroceryListItem(title: "Test Item", subtitle: "Test Subtitle", currentPrice: 10.0)
//        
//        XCTAssertEqual(item.currentPrice, 10.0)
//        XCTAssertEqual(item.priceHistory.count, 1)
//        
//        item.updatePrice(15.0)
//        
//        XCTAssertEqual(item.currentPrice, 15.0)
//        XCTAssertEqual(item.priceHistory.count, 2)
//        XCTAssertEqual(item.priceHistory.last?.price, 15.0)
//    }
//}
//#else
//import XCTAssert
//
//@main
//struct GroceryListItemTests {
//    static func main() async {
//        await testUpdatePrice()
//    }
//    
//    static func testUpdatePrice() async {
//        let item = GroceryListItem(title: "Test Item", subtitle: "Test Subtitle", currentPrice: 10.0)
//        
//        XCTAssertEqual(item.currentPrice, 10.0)
//        XCTAssertEqual(item.priceHistory.count, 1)
//        
//        item.updatePrice(15.0)
//        
//        XCTAssertEqual(item.currentPrice, 15.0)
//        XCTAssertEqual(item.priceHistory.count, 2)
//        XCTAssertEqual(item.priceHistory.last?.price, 15.0)
//        
//        print("All tests passed!")
//    }
//}
//#endif
