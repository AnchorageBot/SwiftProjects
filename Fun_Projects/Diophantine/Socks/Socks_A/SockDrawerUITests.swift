//
// SockDrawer
// SockDrawerUITests.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//

import XCTest

final class SockDrawerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch() // Launch the app in setup
    }

    func testSolutionIsDisplayed() throws {
        let app = XCUIApplication()

        // Tap the "Solution" tab
        app.tabBars["Tab Bar"].buttons["Solution"].tap()

        // Tap the "Find Solution" button
        app.buttons["Find Solution"].tap()

        // Assert that the solution is displayed
        XCTAssertTrue(app.staticTexts["Total Socks: 4"].exists)
        XCTAssertTrue(app.staticTexts["Red Socks: 3"].exists)
        XCTAssertTrue(app.staticTexts["Black Socks: 1"].exists)
    }

    func testNavigationBetweenTabs() throws {
        let app = XCUIApplication()

        // Check if the initial view is present (Sock Data)
        XCTAssertTrue(app.staticTexts["The Sock Drawer Problem"].exists)

        // Navigate to the Solution tab
        app.tabBars["Tab Bar"].buttons["Solution"].tap()
        XCTAssertTrue(app.staticTexts["Solution"].exists)

        // Navigate to the Diophantine tab
        app.tabBars["Tab Bar"].buttons["Diophantine"].tap()
        XCTAssertTrue(app.staticTexts["Diophantine Equations and the Sock Drawer Problem"].exists)

        // Navigate to the About tab
        app.tabBars["Tab Bar"].buttons["About"].tap()
        XCTAssertTrue(app.staticTexts["About This App"].exists)

        // Navigate back to the first tab (Sock Data).
        app.tabBars["Tab Bar"].buttons["Sock Data"].tap()
        XCTAssertTrue(app.staticTexts["The Sock Drawer Problem"].exists)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
