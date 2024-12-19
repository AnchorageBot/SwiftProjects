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
        
        let negativeNoise = RoomData(room: "Study", noise: -5, noNoise: 15)
        #expect(negativeNoise.noise == 0, "Negative noise should be set to 0")
        
        let negativeNoNoise = RoomData(room: "Study", noise: 5, noNoise: -15)
        #expect(negativeNoNoise.noNoise == 0, "Negative no-noise should be set to 0")
    }
    
    @Test
    func testRoomDataCalculations() async throws {
        let room = RoomData(room: "Test", noise: 30, noNoise: 70)
        #expect(room.total == 100, "Total should be sum of noise and no-noise")
    }
    
    // MARK: - ProbabilityCalculator Tests
    
    @Test
    func testProbabilityCalculations() async throws {
        let calculator = ProbabilityCalculator()
        
        // Set test data
        calculator.roomData = [
            RoomData(room: "Bedroom", noise: 20, noNoise: 80),
            RoomData(room: "Study", noise: 10, noNoise: 90)
        ]
        
        // Test prior probabilities
        #expect(abs(calculator.results.priorB - 0.5) < 0.001, "Prior probability for Bedroom should be 0.5")
        #expect(abs(calculator.results.priorS - 0.5) < 0.001, "Prior probability for Study should be 0.5")
        
        // Test likelihoods
        #expect(abs(calculator.results.likelihoodNB - 0.2) < 0.001, "Likelihood P(N|B) should be 0.2")
        #expect(abs(calculator.results.likelihoodNS - 0.1) < 0.001, "Likelihood P(N|S) should be 0.1")
        
        // Test posterior probabilities
        #expect(abs(calculator.results.posteriorBN - 0.667) < 0.001, "Posterior P(B|N) should be approximately 0.667")
        #expect(abs(calculator.results.posteriorSN - 0.333) < 0.001, "Posterior P(S|N) should be approximately 0.333")
    }
    
    @Test
    func testEdgeCases() async throws {
        let calculator = ProbabilityCalculator()
        
        // Test with zero observations
        calculator.roomData = [
            RoomData(room: "Bedroom", noise: 0, noNoise: 0),
            RoomData(room: "Study", noise: 0, noNoise: 0)
        ]
        
        #expect(calculator.results.priorB == 0, "Prior should be 0 with no observations")
        #expect(calculator.results.likelihoodNB == 0, "Likelihood should be 0 with no observations")
        #expect(calculator.results.posteriorBN == 0, "Posterior should be 0 with no observations")
    }
    
    // MARK: - FormattingHelpers Tests
    
    @Test
    func testProbabilityFormatting() async throws {
        #expect(FormattingHelpers.probabilityAsPercentage(0.7532) == "75.32%", "Probability formatting should match expected format")
        #expect(FormattingHelpers.probabilityAsPercentage(1.0) == "100.00%", "Maximum probability should format correctly")
        #expect(FormattingHelpers.probabilityAsPercentage(0.0) == "0.00%", "Zero probability should format correctly")
    }
    
    @Test
    func testObservationCountFormatting() async throws {
        #expect(FormattingHelpers.observationCount(15.6) == "16", "Observation count should round to nearest integer")
        #expect(FormattingHelpers.observationCount(0.0) == "0", "Zero observations should format correctly")
    }
    
    @Test
    func testValidationHelpers() async throws {
        #expect(FormattingHelpers.isValidProbability("0.5") == true, "Valid probability should pass validation")
        #expect(FormattingHelpers.isValidProbability("1.5") == false, "Probability > 1 should fail validation")
        #expect(FormattingHelpers.isValidProbability("-0.5") == false, "Negative probability should fail validation")
        #expect(FormattingHelpers.isValidProbability("abc") == false, "Non-numeric input should fail validation")
        
        #expect(FormattingHelpers.isValidObservationCount("15") == true, "Valid observation count should pass validation")
        #expect(FormattingHelpers.isValidObservationCount("-5") == false, "Negative count should fail validation")
        #expect(FormattingHelpers.isValidObservationCount("abc") == false, "Non-numeric input should fail validation")
    }
}
