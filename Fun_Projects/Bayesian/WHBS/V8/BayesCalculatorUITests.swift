//
// BayesCalculator
// BayesCalculatorUITests.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//
//
// Abstract:
// This test suite validates the user interface functionality of the BayesCalculator app
// through automated UI testing. It verifies navigation flows, data input handling,
// probability calculation updates, and accessibility features. The tests ensure
// the app provides a reliable and user-friendly interface for Bayesian analysis.
//

import XCTest

final class BayesCalculatorUITests: XCTestCase {
    
    // MARK: - Test Lifecycle
    
    override func setUpWithError() throws {
        // Disable test continuation after failures for immediate problem identification
        continueAfterFailure = false
        
        // Reset any persistent state before each test
        let app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launchEnvironment = ["RESET_STATE": "true"]
    }
    
    override func tearDownWithError() throws {
        // Clean up any test-specific state
        let app = XCUIApplication()
        app.terminate()
    }
    
    // MARK: - Navigation Tests
    
    @MainActor
    func testNavigationFlows() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test navigation to About view
        let aboutLink = app.links["About Bayesian Analysis"]
        XCTAssertTrue(aboutLink.exists, "About link should be visible")
        aboutLink.tap()
        
        // Verify About view content
        let aboutTitle = app.navigationBars["About Bayesian Analysis"]
        XCTAssertTrue(aboutTitle.exists, "About view should be displayed")
        
        // Test navigation to Calculator Usage
        let usageLink = app.links["How to Use This Calculator"]
        XCTAssertTrue(usageLink.exists, "Usage link should be visible")
        usageLink.tap()
        
        // Verify Calculator Usage content
        let usageTitle = app.navigationBars["Calculator Usage"]
        XCTAssertTrue(usageTitle.exists, "Usage view should be displayed")
    }
    
    // MARK: - Input Tests
    
    @MainActor
    func testRoomDataInput() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Enter edit mode
        app.buttons["Edit"].tap()
        
        // Test room name input
        let bedroomField = app.textFields["Room name input"].firstMatch
        XCTAssertTrue(bedroomField.exists, "Room name field should be visible")
        bedroomField.tap()
        bedroomField.typeText("Test Room")
        
        // Test noise count input
        let noiseField = app.textFields["Noise count input"].firstMatch
        XCTAssertTrue(noiseField.exists, "Noise count field should be visible")
        noiseField.tap()
        noiseField.typeText("25")
        
        // Test no-noise count input
        let noNoiseField = app.textFields["No noise count input"].firstMatch
        XCTAssertTrue(noNoiseField.exists, "No noise count field should be visible")
        noNoiseField.tap()
        noNoiseField.typeText("75")
        
        // Exit edit mode
        app.buttons["Done"].tap()
    }
    
    // MARK: - Validation Tests
    
    @MainActor
    func testInputValidation() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Enter edit mode
        app.buttons["Edit"].tap()
        
        // Test invalid noise input
        let noiseField = app.textFields["Noise count input"].firstMatch
        noiseField.tap()
        noiseField.typeText("-10")
        
        // Verify validation alert
        let alert = app.alerts["Invalid Input"]
        XCTAssertTrue(alert.exists, "Validation alert should appear for invalid input")
        
        // Dismiss alert
        alert.buttons["OK"].tap()
    }
    
    // MARK: - Results Display Tests
    
    @MainActor
    func testProbabilityDisplay() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test probability section expansion
        let priorGroup = app.staticTexts["PRIOR PROBABILITIES"]
        XCTAssertTrue(priorGroup.exists, "Prior probabilities section should exist")
        priorGroup.tap()
        
        // Verify probability values are displayed
        let probabilityValue = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] '%'")).firstMatch
        XCTAssertTrue(probabilityValue.exists, "Probability value should be displayed")
    }
    
    // MARK: - Performance Tests
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // Measure app launch time
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // MARK: - Accessibility Tests
    
    @MainActor
    func testAccessibilityLabels() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Verify key elements have accessibility labels
        XCTAssertTrue(app.buttons["Edit"].exists, "Edit button should be accessible")
        XCTAssertTrue(app.textFields["Room name input"].exists, "Room name field should be accessible")
        XCTAssertTrue(app.textFields["Noise count input"].exists, "Noise count field should be accessible")
    }
}
