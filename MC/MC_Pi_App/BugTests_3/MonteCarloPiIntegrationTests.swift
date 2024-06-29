//
//  MonteCarloPiIntegrationTests.swift
//  MonteCarloPiIntegrationTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains integration tests for the Monte Carlo Pi Estimation app.
// It focuses on testing how different modules of the app work together,
// ensuring data flows correctly between components, and verifying that
// the UI updates appropriately based on the underlying calculations.
// These tests aim to catch issues that might arise from the interaction
// of different parts of the app.

import XCTest
@testable import MonteCarloPi
import SwiftUI

class MonteCarloPiIntegrationTests: XCTestCase {
    
    var contentView: ContentView!
    
    override func setUpWithError() throws {
        // Initialize the ContentView before each test
        contentView = ContentView()
    }
    
    func testEstimatePiIntegration() {
        // Simulate running the Monte Carlo simulation
        contentView.runSimulation()
        
        // Check if piEstimate has been updated
        XCTAssertNotEqual(contentView.piEstimate, 0, "piEstimate should be updated after running simulation")
        
        // Check if points array has been populated
        XCTAssertFalse(contentView.points.isEmpty, "points array should not be empty after running simulation")
        
        // Verify that the number of points matches the expected count (assuming 10000 is the default)
        XCTAssertEqual(contentView.points.count, 10000, "Number of generated points should match the expected count")
    }
    
    func testDataFlowToChartView() {
        // Run the simulation to generate data
        contentView.runSimulation()
        
        // Create a Mirror to inspect the ContentView's body
        let mirror = Mirror(reflecting: contentView.body)
        
        // Find the Chart view in the body
        let chartView = mirror.children.compactMap { $0.value as? Chart<some View> }.first
        
        // Verify that the Chart view exists
        XCTAssertNotNil(chartView, "Chart view should exist in ContentView")
        
        // Verify that the Chart view is using the points data
        if let chartData = chartView?.data as? [Point] {
            XCTAssertEqual(chartData, contentView.points, "Chart should be using the points data from ContentView")
        } else {
            XCTFail("Failed to access Chart data")
        }
    }
    
    func testToggleContextView() {
        // Initially, showingContext should be false
        XCTAssertFalse(contentView.showingContext, "showingContext should initially be false")
        
        // Simulate tapping the toggle button
        contentView.showingContext.toggle()
        
        // Verify that showingContext is now true
        XCTAssertTrue(contentView.showingContext, "showingContext should be true after toggling")
        
        // Simulate tapping the toggle button again
        contentView.showingContext.toggle()
        
        // Verify that showingContext is back to false
        XCTAssertFalse(contentView.showingContext, "showingContext should be false after toggling again")
    }
    
    func testEstimatePiPerformance() {
        // Measure the performance of the estimatePi function
        measure {
            let _ = estimatePi(numberOfPoints: 100000)
        }
        // This will print the average time taken to run the estimatePi function
    }
}
