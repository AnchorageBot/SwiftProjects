//
// NotesAppV1
// NotesAppV1TestsLaunchTests.swift
//
// Created on 9/3/24
// Swift Version 5.0
//
// ATS Project
//

// Abstract:
// This file contains launch tests for the NotesAppV1 application. It is designed to verify the correct
// launching of the app across different target application UI configurations. The test captures a screenshot
// of the launch screen and attaches it to the test results for visual inspection and documentation purposes.

import XCTest

/// Test case class for NotesAppV1 launch tests
final class NotesAppV1TestsLaunchTests: XCTestCase {

    // MARK: - Configuration

    /// Indicates whether the test should run for each target application UI configuration
    ///
    /// By setting this to `true`, we ensure that the launch test is performed for all
    /// relevant device configurations (e.g., different device sizes, orientations).
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    // MARK: - Setup

    /// Set up the test environment before each test
    ///
    /// This method is called before each test method in the class is invoked.
    override func setUpWithError() throws {
        // Disable the automatic continuation after a failure
        // This ensures that if a test fails, subsequent tests are not executed
        continueAfterFailure = false
    }

    // MARK: - Test Methods

    /// Test the launch of the application
    ///
    /// This method launches the app, allows for any post-launch setup,
    /// captures a screenshot, and attaches it to the test results.
    func testLaunch() throws {
        // Initialize the application
        let app = XCUIApplication()
        
        // Launch the application
        app.launch()

        // NOTE: Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        // Capture a screenshot of the app
        let attachment = XCTAttachment(screenshot: app.screenshot())
        
        // Set the name of the attachment for easy identification
        attachment.name = "Launch Screen"
        
        // Ensure the screenshot is kept even if the test passes
        attachment.lifetime = .keepAlways
        
        // Add the screenshot to the test results
        add(attachment)
    }
}
