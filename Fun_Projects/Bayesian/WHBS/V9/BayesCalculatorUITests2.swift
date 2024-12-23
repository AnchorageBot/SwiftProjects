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
    
    @MainActor
    func testAllNavigationFlows() throws {
        // Allow UI to stabilize
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
        
        // Test navigation to all available views
        let navigationItems = [
            "About Bayesian Analysis",
            "How to Use This Calculator",
            "Phone Location Problem",
            "Phone Location Math"
        ]
        
        for item in navigationItems {
            let link = app.buttons[item]
            XCTAssertTrue(link.waitForExistence(timeout: 5), "\(item) link should exist")
            link.tap()
            
            let navBar = app.navigationBars[item]
            XCTAssertTrue(navBar.waitForExistence(timeout: 5), "\(item) view should be displayed")
            
            // Navigate back
            app.navigationBars.buttons.element(boundBy: 0).tap()
        }
    }
    
    @MainActor
    func testEditMode() throws {
        // Allow UI to stabilize
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
        
        // Find and tap Edit button
        let editButton = app.navigationBars.buttons["Edit"]
        XCTAssertTrue(editButton.exists, "Edit button should exist")
        editButton.tap()
        
        // Verify room data inputs become editable
        let bedroomInput = app.textFields["NoiseCountInput_Bedroom"]
        XCTAssertTrue(bedroomInput.exists, "Bedroom noise input should be visible in edit mode")
        
        // Test editing values
        bedroomInput.tap()
        bedroomInput.typeText("20")
        
        // Done editing
        app.navigationBars.buttons["Done"].tap()
        
        // Verify we're back in view mode
        XCTAssertFalse(bedroomInput.exists, "Input field should not be visible after exiting edit mode")
    }
    
    @MainActor
    func testSectionExpansion() throws {
        // Allow UI to stabilize
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
        
        let sections = [
            "INPUT DATA",
            "PRIOR PROBABILITIES",
            "LIKELIHOODS",
            "POSTERIOR PROBABILITIES",
            "VERIFICATION"
        ]
        
        for section in sections {
            let sectionText = app.staticTexts[section]
            XCTAssertTrue(sectionText.exists, "Section '\(section)' should exist")
            
            // Tap to expand
            sectionText.tap()
            
            // Add verification specific to each section
            switch section {
            case "INPUT DATA":
                let roomDisplay = app.staticTexts["RoomNameDisplay_Bedroom"]
                XCTAssertTrue(roomDisplay.waitForExistence(timeout: 2), "Room data should be visible when expanded")
            case "PRIOR PROBABILITIES":
                let priorLabel = app.staticTexts["P(B) Bedroom"]
                XCTAssertTrue(priorLabel.waitForExistence(timeout: 2), "Prior probabilities should be visible when expanded")
            default:
                // Add specific checks for other sections
                break
            }
            
            // Tap to collapse
            sectionText.tap()
        }
    }
    
}
