
//  MonteCarloSimulation.swift

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

struct MonteCarloSimulation {
    /// Estimates the value of e using Monte Carlo simulation
    /// - Parameter iterations: The number of iterations to run the simulation
    /// - Returns: The estimated value of e
    func estimateE(iterations: Int) -> Double {
        var sum = 0.0
        
        // Perform the simulation for the specified number of iterations
        for _ in 0..<iterations {
            sum += randomSum()
        }
        
        // The estimated value of e is the average of all simulations
        return sum / Double(iterations)
    }
    
    /// Calculates a random sum for a single simulation
    /// - Returns: The result of a single simulation
    private func randomSum() -> Double {
        var sum = 0.0
        var count = 0
        
        // Keep adding random numbers until the sum exceeds 1
        while sum <= 1.0 {
            sum += Double.random(in: 0...1)
            count += 1
        }
        
        return Double(count)
    }
    
    /// Generates random numbers for visualization
    /// - Parameter count: The number of random numbers to generate
    /// - Returns: An array of random CGFloat values between 0 and 1
    func getVisualizationNumbers(count: Int) -> [CGFloat] {
        return (0..<count).map { _ in CGFloat.random(in: 0...1) }
    }
}
