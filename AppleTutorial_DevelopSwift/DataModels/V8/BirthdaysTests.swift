//
//  BirthdaysTests.swift
//  BirthdaysTests
//
//  Created by ATS on 4/20/24
//  Xcode version 15.3
//  Commented and refactored by Claude on 4/22/24
//

/*
 Abstract:
 This file contains the test cases for the Birthdays app. It includes tests for creating and deleting friend entries,
 checking birthday calculations, and verifying the performance of the app's core functionalities.
 The test cases ensure the correctness and performance of the Birthdays app's data management and business logic.

 References:
 - XCTest Documentation
   https://developer.apple.com/documentation/xctest
 - XCTest Assertions
   https://developer.apple.com/documentation/xctest/xctestcase/checking_assumptions_with_assertions
 - XCTest Performance Testing
   https://developer.apple.com/documentation/xctest/performance_tests
 - ModelContext and ModelContainer Documentation
   https://developer.apple.com/documentation/swiftdata/modelcontext
   https://developer.apple.com/documentation/swiftdata/modelcontainer
*/

import XCTest
import SwiftData
@testable import Birthdays

final class BirthdaysTests: XCTestCase {
    
    // MARK: - Properties
    
    var context: ModelContext!
    
    // MARK: - Setup and Teardown
    
    override func setUpWithError() throws {
        // Set up the model context for testing
        let modelContainer = ModelContainer(for: Friend.self)
        context = try! ModelContext(modelContainer)
    }
    
    override func tearDownWithError() throws {
        // Clean up the model context after testing
        context = nil
    }
    
    // MARK: - Test Cases
    
    func testCreateFriend() throws {
        // Test creating a new friend entry
        let name = "John Doe"
        let birthday = Date()
        
        let friend = Friend(name: name, birthday: birthday)
        context.insert(friend)
        
        do {
            let fetchedFriends: [Friend] = try context.fetch(FetchDescriptor<Friend>())
            
            XCTAssertEqual(fetchedFriends.count, 1, "Expected one friend entry after creation")
            XCTAssertEqual(fetchedFriends.first?.name, name, "Expected friend name to match")
            XCTAssertEqual(fetchedFriends.first?.birthday, birthday, "Expected friend birthday to match")
        } catch {
            XCTFail("Failed to fetch friends: \(error)")
        }
    }
    
    func testDeleteFriend() throws {
        // Test deleting a friend entry
        let friend = Friend(name: "Jane Smith", birthday: Date())
        context.insert(friend)
        
        context.delete(friend)
        
        do {
            let fetchedFriends: [Friend] = try context.fetch(FetchDescriptor<Friend>())
            
            XCTAssertEqual(fetchedFriends.count, 0, "Expected no friend entries after deletion")
        } catch {
            XCTFail("Failed to fetch friends: \(error)")
        }
    }
    
    func testBirthdayToday() throws {
        // Test checking if a friend's birthday is today
        let today = Date()
        let friend = Friend(name: "Alice", birthday: today)
        
        XCTAssertTrue(friend.isBirthdayToday, "Expected friend's birthday to be today")
    }
    
    func testBirthdayNotToday() throws {
        // Test checking if a friend's birthday is not today
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let friend = Friend(name: "Bob", birthday: pastDate)
        
        XCTAssertFalse(friend.isBirthdayToday, "Expected friend's birthday not to be today")
    }
    
    func testPerformanceCreateFriend() throws {
        // Test the performance of creating a friend entry
        self.measure {
            let friend = Friend(name: "Performance Test", birthday: Date())
            context.insert(friend)
        }
    }
    
    func testPerformanceDeleteFriend() throws {
        // Test the performance of deleting a friend entry
        let friend = Friend(name: "Performance Test", birthday: Date())
        context.insert(friend)
        
        self.measure {
            context.delete(friend)
        }
    }
}
