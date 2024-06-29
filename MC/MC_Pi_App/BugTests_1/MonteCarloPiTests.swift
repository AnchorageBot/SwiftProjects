//
//  MonteCarloPiTests.swift
//  MonteCarloPiTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains unit tests for the Monte Carlo Pi estimation app.
// It tests the core functionality of the estimatePi function, the Point struct,
// and various edge cases and consistency checks. These tests ensure the
// reliability and accuracy of the Pi estimation algorithm.

import XCTest
@testable import MonteCarloPi

class MonteCarloPiTests: XCTestCase {
    
    func testEstimatePi() {
        // Run the Pi estimation with a large number of points
        let (estimate, points) = estimatePi(numberOfPoints: 100000)
        
        // Test if the estimate is within a reasonable range
        XCTAssertTrue(estimate > 3.0 && estimate < 3.2, "Pi estimate should be between 3.0 and 3.2")
        
        // Test if the number of points matches the input
        XCTAssertEqual(points.count, 100000, "Number of generated points should match the input")
        
        // Test if all points are within the 1x1 square
        for point in points {
            XCTAssertTrue(point.x >= 0 && point.x <= 1, "X coordinate should be between 0 and 1")
            XCTAssertTrue(point.y >= 0 && point.y <= 1, "Y coordinate should be between 0 and 1")
        }
    }
    
    func testPointStruct() {
        // Create a test Point
        let point = Point(x: 0.5, y: 0.7)
        
        // Test if the x coordinate is correctly set
        XCTAssertEqual(point.x, 0.5, "X coordinate should be correctly set")
        
        // Test if the y coordinate is correctly set
        XCTAssertEqual(point.y, 0.7, "Y coordinate should be correctly set")
    }
    
    func testEstimatePiZeroPoints() {
        // Run the Pi estimation with zero points
        let (estimate, points) = estimatePi(numberOfPoints: 0)
        
        // Test if the estimate is NaN for zero points
        XCTAssertTrue(estimate.isNaN, "Estimate should be NaN for zero points")
        
        // Test if the points array is empty for zero points
        XCTAssertTrue(points.isEmpty, "Points array should be empty for zero points")
    }
    
    func testEstimatePiConsistency() {
        // Set the number of points for estimation
        let numberOfPoints = 10000
        
        // Run the estimation twice
        let (estimate1, _) = estimatePi(numberOfPoints: numberOfPoints)
        let (estimate2, _) = estimatePi(numberOfPoints: numberOfPoints)
        
        // Check if estimates are close to each other (within 0.1)
        XCTAssertLessThan(abs(estimate1 - estimate2), 0.1, "Estimates should be consistent within a small margin")
    }
}
