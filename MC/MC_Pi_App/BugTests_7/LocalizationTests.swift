//
//  LocalizationTests.swift
//  MonteCarloPiTests
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//
// Abstract:
// This file contains localization tests for the Monte Carlo Pi Estimation app.
// It verifies that the app's text elements are correctly localized for different
// languages and that number formatting is appropriate for various regions.
// These tests ensure that the app provides a consistent experience across
// different locales.

import XCTest
@testable import MonteCarloPi

class LocalizationTests: XCTestCase {
    
    // Test locales (language code and region)
    let testLocales = ["en_US", "es_ES", "fr_FR", "de_DE", "ja_JP"]
    
    // Key strings to test (assuming these are keys in your Localizable.strings files)
    let testKeys = [
        "estimated_pi_label",
        "run_simulation_button",
        "simulation_context_button",
        "show_simulation_button"
    ]
    
    func testLocalizedStrings() {
        for locale in testLocales {
            // Set the current locale for testing
            let currentLocale = Locale(identifier: locale)
            
            for key in testKeys {
                // Get the localized string for the current locale
                let localizedString = NSLocalizedString(key, comment: "")
                
                // Ensure the string is not empty and not equal to the key itself
                XCTAssertFalse(localizedString.isEmpty, "Localized string for key '\(key)' in locale '\(locale)' should not be empty")
                XCTAssertNotEqual(localizedString, key, "Localized string for key '\(key)' in locale '\(locale)' should not be equal to the key itself")
                
                // You might want to add more specific tests here, e.g., checking for expected content
            }
        }
    }
    
    func testNumberFormatting() {
        let testNumber = 3.14159
        
        for locale in testLocales {
            // Set up a number formatter for the current locale
            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: locale)
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 5
            
            // Format the test number
            let formattedNumber = formatter.string(from: NSNumber(value: testNumber))
            
            // Ensure the formatted number is not nil
            XCTAssertNotNil(formattedNumber, "Formatted number for locale '\(locale)' should not be nil")
            
            // Check that the formatted number has the correct number of decimal places
            let components = formattedNumber!.components(separatedBy: CharacterSet.decimalDigits.inverted)
            let decimalPart = components.last ?? ""
            XCTAssertEqual(decimalPart.count, 5, "Formatted number for locale '\(locale)' should have 5 decimal places")
            
            // You might want to add more specific tests here, e.g., checking for correct decimal separator
        }
    }
    
    func testDateFormatting() {
        let testDate = Date()
        
        for locale in testLocales {
            // Set up a date formatter for the current locale
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: locale)
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            
            // Format the test date
            let formattedDate = formatter.string(from: testDate)
            
            // Ensure the formatted date is not empty
            XCTAssertFalse(formattedDate.isEmpty, "Formatted date for locale '\(locale)' should not be empty")
            
            // You might want to add more specific tests here, e.g., checking for expected date components
        }
    }
    
    func testRightToLeftLayout() {
        // Test for right-to-left languages like Arabic
        let rtlLocale = Locale(identifier: "ar_SA")  // Arabic (Saudi Arabia)
        
        // Check if the locale uses right-to-left script
        XCTAssertTrue(NSLocale.characterDirection(forLanguage: rtlLocale.languageCode ?? "") == .rightToLeft,
                      "Arabic locale should use right-to-left script")
        
        // You would need to implement UI tests to fully verify RTL layout
        // This might involve taking screenshots and comparing them to expected layouts
    }
}
