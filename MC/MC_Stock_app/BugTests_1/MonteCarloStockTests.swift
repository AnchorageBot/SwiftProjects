//
//  MonteCarloStockTests.swift
//  MonteCarloStockTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains unit tests for the Monte Carlo Stock Price Simulation app.
// It tests the core functionality of the simulation, including price generation,
// statistical calculations, and edge cases. These tests ensure the reliability
// and accuracy of the stock price simulation algorithm.

import XCTest
@testable import MonteCarloStock

class MonteCarloStockTests: XCTestCase {
    
    func testRunSimulation() {
        let contentView = ContentView()
        
        // Set up test parameters
        contentView.initialPrice = 100.0
        contentView.numDays = 30
        contentView.annualVolatility = 0.3
        contentView.annualDrift = 0.05
        
        // Run the simulation
        contentView.runSimulation()
        
        // Test if the simulation generates the correct number of price series
        XCTAssertEqual(contentView.simulatedPrices.count, contentView.numSimulations, "Number of simulated price series should match numSimulations")
        
        // Test if each price series has the correct number of days
        XCTAssertEqual(contentView.simulatedPrices[0].count, contentView.numDays + 1, "Each price series should have numDays + 1 data points")
        
        // Test if the mean final price is within a reasonable range
        XCTAssertTrue(contentView.meanFinalPrice > 90 && contentView.meanFinalPrice < 110, "Mean final price should be within a reasonable range")
        
        // Test if the confidence interval is properly calculated
        XCTAssertTrue(contentView.lowEstimate < contentView.meanFinalPrice && contentView.highEstimate > contentView.meanFinalPrice, "Confidence interval should contain the mean final price")
    }
    
    func testPriceGeneration() {
        let contentView = ContentView()
        
        // Set up test parameters
        contentView.initialPrice = 100.0
        contentView.numDays = 1
        contentView.annualVolatility = 0.0  // No volatility
        contentView.annualDrift = 0.0  // No drift
        
        // Run the simulation
        contentView.runSimulation()
        
        // Test if the price remains unchanged when there's no volatility and no drift
        XCTAssertEqual(contentView.simulatedPrices[0][1].price, 100.0, accuracy: 0.01, "Price should remain unchanged with no volatility and no drift")
    }
    
    func testEdgeCases() {
        let contentView = ContentView()
        
        // Test with zero initial price
        contentView.initialPrice = 0.0
        contentView.runSimulation()
        XCTAssertEqual(contentView.meanFinalPrice, 0.0, "Mean final price should be zero when initial price is zero")
        
        // Test with zero days
        contentView.initialPrice = 100.0
        contentView.numDays = 0
        contentView.runSimulation()
        XCTAssertEqual(contentView.simulatedPrices[0].count, 1, "Should only have initial price when numDays is zero")
        
        // Test with extreme volatility
        contentView.numDays = 30
        contentView.annualVolatility = 10.0  // Extremely high volatility
        contentView.runSimulation()
        XCTAssertTrue(contentView.highEstimate > contentView.initialPrice * 2, "High estimate should be significantly higher with extreme volatility")
    }
}
