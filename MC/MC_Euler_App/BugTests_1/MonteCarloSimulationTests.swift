// MonteCarloSimulationTests.swift

//
//  Created by ATS and Claude on 6/28/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains unit tests for the MonteCarloSimulation struct.
// It verifies the correctness of the Monte Carlo estimation of e and the random number generation for visualization.

// Narrative:
// These unit tests ensure that the core functionality of our Monte Carlo simulation is working correctly.
// We test the accuracy of the e estimation and the properties of the generated random numbers for visualization.
// Regular execution of these tests helps maintain the reliability of our simulation algorithm.

import XCTest
@testable import MonteCarloSimulationApp

class MonteCarloSimulationTests: XCTestCase {
    
    // Test the estimation of e
    func testEstimateE() {
        // Create an instance of MonteCarloSimulation
        let simulation = MonteCarloSimulation()
        
        // Run the simulation with 1 million iterations
        let result = simulation.estimateE(iterations: 1_000_000)
        
        // Check if the result is close to the actual value of e (2.71828)
        // We allow for a small margin of error (0.01) due to the nature of Monte Carlo simulations
        XCTAssertEqual(result, 2.71828, accuracy: 0.01)
    }
    
    // Test the generation of random numbers for visualization
    func testVisualizationNumbers() {
        // Create an instance of MonteCarloSimulation
        let simulation = MonteCarloSimulation()
        
        // Generate 100 random numbers for visualization
        let numbers = simulation.getVisualizationNumbers(count: 100)
        
        // Verify that we got the correct number of random values
        XCTAssertEqual(numbers.count, 100)
        
        // Check that each number is within the expected range [0, 1]
        for number in numbers {
            XCTAssertGreaterThanOrEqual(number, 0)
            XCTAssertLessThanOrEqual(number, 1)
        }
    }
    
    // Test the performance of the e estimation
    func testPerformanceOfEstimateE() {
        // Create an instance of MonteCarloSimulation
        let simulation = MonteCarloSimulation()
        
        // Measure the performance of running the simulation with 1 million iterations
        measure {
            _ = simulation.estimateE(iterations: 1_000_000)
        }
    }
}
