//
// SockDrawer
// SockDrawerUITestsLaunchTests.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//

import XCTest

final class SockDrawerUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    func testLaunchAndCaptureScreenshot() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the app to launch fully before taking a screenshot
        sleep(2) // Adjust the sleep time based on your app's launch time

        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
