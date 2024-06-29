//
//  MonteCarloPiUITests.swift
//  MonteCarloPiUITests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains UI tests for the Monte Carlo Pi Estimation app using XCUITest.
// It simulates user interactions, tests the app's responsiveness to different device
// sizes and orientations, and verifies the presence and functionality of key UI elements.
// These tests ensure that the app's user interface is working correctly across various scenarios.

import XCTest

class MonteCarloPiUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Disable any automatic UI recordings
        continueAfterFailure = false
        
        // Launch the app before each test
        app.launch()
    }
    
    func testMainViewElements() throws {
        // Verify that the main view contains the expected elements
        XCTAssertTrue(app.staticTexts["Estimated value of π:"].exists, "Pi estimation label should exist")
        XCTAssertTrue(app.buttons["Run Simulation"].exists, "Run Simulation button should exist")
        XCTAssertTrue(app.buttons["Simulation Context"].exists, "Simulation Context button should exist")
    }
    
    func testRunSimulation() throws {
        // Tap the Run Simulation button
        app.buttons["Run Simulation"].tap()
        
        // Wait for the estimation to complete (adjust timeout as needed)
        let piEstimateLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Estimated value of π:'")).element
        XCTAssertTrue(piEstimateLabel.waitForExistence(timeout: 5), "Pi estimation should appear after running simulation")
        
        // Verify that the estimation value is not empty
        XCTAssertFalse(piEstimateLabel.label.hasSuffix(":"), "Pi estimation value should not be empty")
    }
    
    func testContextView() throws {
        // Tap the Simulation Context button
        app.buttons["Simulation Context"].tap()
        
        // Verify that the context view appears
        XCTAssertTrue(app.staticTexts["Monte Carlo Method for Estimating Pi"].exists, "Context view title should exist")
        
        // Verify that the Show Simulation button exists
        XCTAssertTrue(app.buttons["Show Simulation"].exists, "Show Simulation button should exist in context view")
        
        // Return to the main view
        app.buttons["Show Simulation"].tap()
        
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
        XCTAssertTrue(app.buttons["Simulation Context"].isHittable, "Simulation Context button should be hittable")
    }
}
