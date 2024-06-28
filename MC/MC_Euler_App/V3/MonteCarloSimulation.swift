// MonteCarloSimulation.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the core logic for the Monte Carlo simulation to estimate e.
// It provides methods for running the simulation and generating random numbers for visualization.
// The Monte Carlo method used here involves summing random numbers until exceeding 1.

import Foundation
import SwiftUI

// Define the Monte Carlo simulation struct
struct MonteCarloSimulation {
    // Function to estimate the value of e
    func estimateE(iterations: Int) -> Double {
        // Initialize sum
        var sum = 0.0
        
        // Perform the simulation for the specified number of iterations
        for _ in 0..<iterations {
            sum += randomSum()
        }
        
        // Return the average as the estimate of e
        return sum / Double(iterations)
    }
    
    // Function to perform a single random sum experiment
    private func randomSum() -> Double {
        // Initialize variables
        var sum = 0.0
        var count = 0
        
        // Add random numbers until the sum exceeds 1
        while sum <= 1.0 {
            sum += Double.random(in: 0...1)
            count += 1
        }
        
        // Return the count as a Double
        return Double(count)
    }
    
    // Function to generate random numbers for visualization
    func getVisualizationNumbers(count: Int) -> [CGFloat] {
        // Generate an array of random CGFloat values
        return (0..<count).map { _ in CGFloat.random(in: 0...1) }
    }
}
