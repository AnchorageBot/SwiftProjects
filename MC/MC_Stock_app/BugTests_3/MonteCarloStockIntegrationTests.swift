//
//  MonteCarloStockIntegrationTests.swift
//  MonteCarloStockIntegrationTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains integration tests for the Monte Carlo Stock Price Simulator app.
// It focuses on testing how different modules of the app work together,
// ensuring data flows correctly between components, and verifying that
// the UI updates appropriately based on the underlying calculations.
// These tests aim to catch issues that might arise from the interaction
// of different parts of the app.

import XCTest
@testable import MonteCarloStock
import SwiftUI
import Charts

class MonteCarloStockIntegrationTests: XCTestCase {
    
    var contentView: ContentView!
    
    override func setUpWithError() throws {
        // Initialize the ContentView before each test
        contentView = ContentView()
    }
    
    func testRunSimulationIntegration() {
        // Set initial values
        contentView.initialPrice = 100.0
        contentView.numDays = 30
        contentView.annualVolatility = 0.3
        contentView.annualDrift = 0.05
        
        // Simulate running the Monte Carlo simulation
        contentView.runSimulation()
        
        // Check if simulatedPrices has been updated
        XCTAssertFalse(contentView.simulatedPrices.isEmpty, "simulatedPrices should not be empty after running simulation")
        
        // Check if meanFinalPrice has been updated
        XCTAssertNotEqual(contentView.meanFinalPrice, 0, "meanFinalPrice should be updated after running simulation")
        
        // Verify that the number of simulations matches the expected count
        XCTAssertEqual(contentView.simulatedPrices.count, contentView.numSimulations, "Number of simulations should match the expected count")
        
        // Verify that each simulation has the correct number of days
        XCTAssertEqual(contentView.simulatedPrices[0].count, contentView.numDays + 1, "Each simulation should have numDays + 1 price points")
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
        
        // Verify that the Chart view is using the simulatedPrices data
        if let chartData = chartView?.data as? [[StockPrice]] {
            XCTAssertEqual(chartData.count, min(100, contentView.simulatedPrices.count), "Chart should be using up to 100 simulated price series")
        } else {
            XCTFail("Failed to access Chart data")
        }
    }
    
    func testGlossaryNavigation() {
        // Create a Mirror to inspect the ContentView's body
        let mirror = Mirror(reflecting: contentView.body)
        
        // Find the NavigationLink to the GlossaryView
        let glossaryLink = mirror.children.compactMap { $0.value as? NavigationLink<Text, GlossaryView> }.first
        
        // Verify that the NavigationLink exists
        XCTAssertNotNil(glossaryLink, "NavigationLink to GlossaryView should exist in ContentView")
        
        // Verify that the destination of the NavigationLink is GlossaryView
        XCTAssertNotNil(glossaryLink?.destination as? GlossaryView, "Destination of NavigationLink should be GlossaryView")
    }
    
    func testRunSimulationPerformance() {
        // Measure the performance of the runSimulation function
        measure {
            contentView.runSimulation()
        }
        // This will print the average time taken to run the simulation
    }
}
