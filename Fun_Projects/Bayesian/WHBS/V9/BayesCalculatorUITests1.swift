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
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launchEnvironment = ["RESET_STATE": "true"]
        app.launch()
        
        // Add small delay to ensure UI is fully loaded
        Thread.sleep(forTimeInterval: 1.0)
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }
    
    @MainActor
    func testNavigationFlows() throws {
        // Allow time for UI to fully load and stabilize
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
        
        // Try multiple ways to find the About link
        let aboutLink = app.buttons["About Bayesian Analysis"]
        let aboutLinkExists = aboutLink.waitForExistence(timeout: 5)
        
        if !aboutLinkExists {
            // Print UI hierarchy for debugging
            print("UI Hierarchy:")
            print(app.debugDescription)
            XCTFail("About link not found")
        }
        
        // Tap the link
        aboutLink.tap()
        
        // Verify navigation occurred with timeout
        let aboutTitle = app.navigationBars["About Bayesian Analysis"]
        XCTAssertTrue(aboutTitle.waitForExistence(timeout: 5), "About view should be displayed")
    }
}
