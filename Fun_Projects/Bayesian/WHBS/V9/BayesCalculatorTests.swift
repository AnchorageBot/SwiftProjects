//
// BayesCalculator
// BayesCalculatorTests.swift
//
// Created on 12/14/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//
//
// Abstract:
// This test suite validates the core functionality of the BayesCalculator
// app, including probability calculations, data validation, and formatting
// helpers. It ensures accurate Bayesian analysis calculations and proper
// handling of edge cases.
//

import Testing
@testable import BayesCalculator

/// Test suite for BayesCalculator functionality
struct BayesCalculatorTests {
    
    // MARK: - RoomData Tests
    
    @Test
    func testRoomDataValidation() async throws {
        // Test valid room data
        let validRoom = RoomData(room: "Bedroom", noise: 15, noNoise: 135)
        #expect(validRoom.isValid == true, "Valid room data should pass validation")
        
        // Test invalid room data
        let emptyRoom = RoomData(room: "", noise: 15, noNoise: 135)
        #expect(emptyRoom.isValid == false, "Empty room name should fail validation")
        
        // Test negative noise handling - create and then check value
        var negativeNoise = RoomData(room: "Study", noise: -5, noNoise: 15)
        negativeNoise.noise = -5  // This will trigger the didSet
        #expect(negativeNoise.noise == 0, "Negative noise should be set to 0")
        
        // Test negative no-noise handling - create and then check value
        var negativeNoNoise = RoomData(room: "Study", noise: 5, noNoise: -15)
        negativeNoNoise.noNoise = -15  // This will trigger the didSet
        #expect(negativeNoNoise.noNoise == 0, "Negative no-noise should be set to 0")
    }
    
    @Test
    func testEdgeCases() async throws {
        let calculator = ProbabilityCalculator()
        
        // Initialize calculator with empty observations
        calculator.roomData = [
            RoomData(room: "Bedroom", noise: 0, noNoise: 0),
            RoomData(room: "Study", noise: 0, noNoise: 0)
        ]
        
        // Force update of calculations
        calculator.validateAndCalculate()
        
        // Allow time for calculations to update
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
        
        // Test zero observation case
        let totalObservations = calculator.roomData.reduce(0) { $0 + $1.total }
        #expect(totalObservations == 0, "Total observations should be 0")
        #expect(calculator.results.priorB == 0, "Prior probability should be 0 with no observations")
        #expect(calculator.results.likelihoodNB == 0, "Likelihood should be 0 with no observations")
        #expect(calculator.results.posteriorBN == 0, "Posterior should be 0 with no observations")
    }
}
