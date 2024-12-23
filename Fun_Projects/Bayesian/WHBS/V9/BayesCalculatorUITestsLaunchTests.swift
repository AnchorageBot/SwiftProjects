//
// BayesCalculator
// BayesCalculatorUITestsLaunchTests.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//
//
// Abstract:
// This test suite validates the launch process of the BayesCalculator app.
// It verifies that the app launches successfully, all critical UI elements
// are present and properly rendered, and initial state is correctly set.
//

import XCTest

final class BayesCalculatorUITestsLaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Allow app to settle
        Thread.sleep(forTimeInterval: 1.0)
        
        // Verify critical UI sections exist
        let sections = [
            "PRIOR PROBABILITIES",
            "LIKELIHOODS",
            "POSTERIOR PROBABILITIES",
            "VERIFICATION"
        ]
        
        for section in sections {
            let sectionText = app.staticTexts[section]
            XCTAssertTrue(sectionText.exists, "Section '\(section)' should exist")
        }
    }

    @MainActor
    func testInitialState() throws {
        let app = XCUIApplication()
        app.launch()

        // Allow app to settle
        Thread.sleep(forTimeInterval: 1.0)
        
        // Verify room labels exist
        let roomNameDisplay = app.staticTexts["RoomNameDisplay_Bedroom"]
        XCTAssertTrue(roomNameDisplay.exists, "Room name display should exist")
    }
}
