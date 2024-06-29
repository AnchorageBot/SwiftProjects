// ContentViewIntegrationTests.swift

//
//  Created by ATS and Claude on 6/28/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains integration tests for the ContentView of the Monte Carlo Simulation app.
// It verifies the interaction between the MonteCarloSimulation and the ContentView.

// Narrative:
// These integration tests ensure that the ContentView correctly interacts with the MonteCarloSimulation.
// We test that running a simulation through the ContentView updates the state variables as expected.
// This helps catch any issues in the integration between the UI and the core simulation logic.

import XCTest
import SwiftUI
@testable import MonteCarloSimulationApp

class ContentViewIntegrationTests: XCTestCase {
    
    func testRunSimulation() {
        // Create an instance of ContentView
        let contentView = ContentView()
        
        // Run the simulation
        contentView.runSimulation()
        
        // Check if estimatedE is set
        // The estimatedE should not be nil after running the simulation
        XCTAssertNotNil(contentView.estimatedE)
        
        // Check if randomNumbers are generated
        // We expect 100 random numbers to be generated for visualization
        XCTAssertEqual(contentView.randomNumbers.count, 100)
    }
}
