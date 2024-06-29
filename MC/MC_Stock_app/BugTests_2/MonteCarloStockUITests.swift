//
//  MonteCarloStockUITests.swift
//  MonteCarloStockUITests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains UI tests for the Monte Carlo Stock Price Simulator app using XCUITest.
// It simulates user interactions, tests the app's responsiveness to different device
// sizes and orientations, and verifies the presence and functionality of key UI elements.
// These tests ensure that the app's user interface is working correctly across various scenarios.

import XCTest

class MonteCarloStockUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Disable any automatic UI recordings
        continueAfterFailure = false
        
        // Launch the app before each test
        app.launch()
    }
    
    func testMainViewElements() throws {
        // Verify that the main view contains the expected elements
        XCTAssertTrue(app.staticTexts["Initial Price:"].exists, "Initial Price label should exist")
        XCTAssertTrue(app.staticTexts["Number of Days:"].exists, "Number of Days label should exist")
        XCTAssertTrue(app.staticTexts["Annual Volatility:"].exists, "Annual Volatility label should exist")
        XCTAssertTrue(app.staticTexts["Annual Drift:"].exists, "Annual Drift label should exist")
        XCTAssertTrue(app.buttons["Run Simulation"].exists, "Run Simulation button should exist")
        XCTAssertTrue(app.buttons["Glossary"].exists, "Glossary button should exist")
    }
    
    func testRunSimulation() throws {
        // Enter test values
        app.textFields[""].element(boundBy: 0).tap()
        app.textFields[""].element(boundBy: 0).typeText("100")
        app.textFields[""].element(boundBy: 1).tap()
        app.textFields[""].element(boundBy: 1).typeText("30")
        app.textFields[""].element(boundBy: 2).tap()
        app.textFields[""].element(boundBy: 2).typeText("0.3")
        app.textFields[""].element(boundBy: 3).tap()
        app.textFields[""].element(boundBy: 3).typeText("0.05")
        
        // Tap the Run Simulation button
        app.buttons["Run Simulation"].tap()
        
        // Wait for the simulation to complete (adjust timeout as needed)
        let meanPriceLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Mean Estimated Price:'")).element
        XCTAssertTrue(meanPriceLabel.waitForExistence(timeout: 5), "Mean Estimated Price should appear after running simulation")
        
        // Verify that the estimation values are not empty
        XCTAssertFalse(meanPriceLabel.label.hasSuffix(":"), "Mean Estimated Price value should not be empty")
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH '95% Confidence Interval:'")).element.exists, "Confidence Interval should exist")
    }
    
    func testGlossaryView() throws {
        // Tap the Glossary button
        app.buttons["Glossary"].tap()
        
        // Verify that the glossary view appears
        XCTAssertTrue(app.navigationBars["Glossary"].exists, "Glossary view title should exist")
        
        // Verify that some glossary terms exist
        XCTAssertTrue(app.staticTexts["Monte Carlo Simulation"].exists, "Monte Carlo Simulation term should exist in glossary")
        XCTAssertTrue(app.staticTexts["Volatility"].exists, "Volatility term should exist in glossary")
        
        // Return to the main view
        app.navigationBars["Glossary"].buttons["Stock Price Simulator"].tap()
        
        // Verify that we're back on the main view
        XCTAssertTrue(app.buttons["Run Simulation"].exists, "Should return to main view with Run Simulation button")
    }
    
    func testDifferentOrientations() throws {
        // Test in portrait orientation
        XCUIDevice.shared.orientation = .portrait
        XCTAssertTrue(app.buttons["Run Simulation"].exists, "Run Simulation button should exist in portrait")
        
        // Test in landscape orientation
        XCUIDevice.shared.orientation = .landscapeLeft
        XCTAssertTrue(app.buttons["Run Simulation"].exists, "Run Simulation button should exist in landscape")
    }
    
    func testDifferentDeviceSizes() throws {
        // This test should be run on different device simulators to be effective
        // Here we're just checking if key elements are visible on the current device
        XCTAssertTrue(app.buttons["Run Simulation"].isHittable, "Run Simulation button should be hittable")
        XCTAssertTrue(app.buttons["Glossary"].isHittable, "Glossary button should be hittable")
    }
}
