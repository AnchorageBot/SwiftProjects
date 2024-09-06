//
// TipCalculator
// CalculationTests.swift
//
// Created on 9/5/24
// Swift Version 5.0
//
// ATS Project
//


import XCTest
@testable import TipCalculator

final class CalculationTests: XCTestCase {
    
    func testSuccessfulTipCalculation() {
        // Given (Arrange)
        let enteredAmount = 100.00
        let tipSlider = 25.0
        let calculation = Calculation()
        
        // When (Act)
        let tip = calculation.calculateTip(of: enteredAmount, with: tipSlider)
        
        // Then (Assert)
        XCTAssertEqual(tip, 25)
    }
    
}
