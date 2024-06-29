// MonteCarloSimulationUITests.swift

//
//  Created by ATS and Claude on 6/28/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains UI tests for the Monte Carlo Simulation app.
// It verifies the main user flow, including running a simulation, displaying results, and navigating between views.

// Narrative:
// These UI tests ensure that the app's user interface is functioning correctly.
// We test the initial state, running a simulation, result display, and navigation between different views.
// These tests help catch any regressions in the UI functionality and ensure a smooth user experience.

import XCTest

class MonteCarloSimulationUITests: XCTestCase {
    
    func testSimulationFlow() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        // Test initial state
        // Verify that the initial prompt is displayed
        XCTAssertTrue(app.staticTexts["Press 'Simulate' to estimate e"].exists)
        
        // Run simulation
        // Tap the Simulate button
        app.buttons["Simulate"].tap()
        
        // Check if result is displayed
        // Look for text that starts with "Estimated value of e:"
        let resultText = app.staticTexts.matching(NSPredicate(format: "label BEGINSWITH 'Estimated value of e:'")).firstMatch
        // Wait for the result to appear (timeout after 5 seconds)
        XCTAssertTrue(resultText.waitForExistence(timeout: 5))
        
        // Navigate to Context view
        // Tap the Context button
        app.buttons["Context"].tap()
        // Verify that the Context view title is displayed
        XCTAssertTrue(app.staticTexts["Estimating e using Monte Carlo Simulation"].exists)
        
        // Navigate to Calculate view
        // Tap the Calculate button
        app.buttons["Calculate"].tap()
        // Verify that the Calculate view title is displayed
        XCTAssertTrue(app.staticTexts["Compound Interest Calculator"].exists)
    }
    
    func testAccessibility() {
        // Launch the app
        let app = XCUIApplication()
        app.launch()
        
        // Check if main elements are accessible
        // Verify that the Simulate button is accessible
        XCTAssertTrue(app.buttons["Simulate"].isAccessibilityElement)
        // Verify that the Context button is accessible
        XCTAssertTrue(app.buttons["Context"].isAccessibilityElement)
        // Verify that the Calculate button is accessible
        XCTAssertTrue(app.buttons["Calculate"].isAccessibilityElement)
    }
}
