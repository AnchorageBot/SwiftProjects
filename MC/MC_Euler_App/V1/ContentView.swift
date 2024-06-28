// ContentView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the main view of the Monte Carlo Simulation app.
// It manages the UI for running simulations, displaying results, and showing context information.
// The view includes a visualization of random numbers with y-axes and buttons for user interaction.

// Import the SwiftUI framework
import SwiftUI

// Define the main ContentView struct
struct ContentView: View {
    // State variable to toggle between simulation and context views
    @State private var showingContext = false
    // State variable to store the estimated value of e
    @State private var estimatedE: Double?
    // State variable to store random numbers for visualization
    @State private var randomNumbers: [CGFloat] = Array(repeating: 0, count: 100)
    
    // Define the body of the view
    var body: some View {
        // Create a vertical stack of views
        VStack {
            // Conditionally display either ContextView or SimulationView
            if showingContext {
                // Display ContextView if showingContext is true
                ContextView(showingContext: $showingContext, runSimulation: runSimulation)
            } else {
                // Display SimulationView if showingContext is false
                SimulationView(estimatedE: estimatedE, randomNumbers: randomNumbers)
                
                // Button to run the simulation
                Button(action: runSimulation) {
                    Text("Run Simulation")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // Button to show context
                Button(action: { showingContext = true }) {
                    Text("Show Context")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    // Private function to run the Monte Carlo simulation
    private func runSimulation() {
        // Create a new MonteCarloSimulation instance
        let simulation = MonteCarloSimulation()
        // Estimate the value of e and store it
        self.estimatedE = simulation.estimateE(iterations: 1_000_000)
        // Get random numbers for visualization
        self.randomNumbers = simulation.getVisualizationNumbers(count: 100)
        // Set showingContext to false to display simulation results
        self.showingContext = false
    }
}

// Define the SimulationView struct
struct SimulationView: View {
    // Properties to store the estimated value of e and random numbers
    let estimatedE: Double?
    let randomNumbers: [CGFloat]
    
    // Define the body of the view
    var body: some View {
        // Create a vertical stack of views
        VStack {
            // Conditionally display the estimated value of e or a prompt
            if let e = estimatedE {
                Text("Estimated value of e: \(e, specifier: "%.6f")")
                    .font(.title)
                    .padding()
            } else {
                Text("Run the simulation to estimate e")
                    .font(.title)
                    .padding()
            }
            
            // Graphic with y-axes and white space on sides
            HStack(spacing: 0) {
                // Left white space
                Color.white.frame(width: 20)
                
                // Left y-axis
                YAxisView()
                
                // Graph
                ZStack(alignment: .bottom) {
                    // Background grid
                    VStack(spacing: 0) {
                        ForEach(0..<5) { _ in
                            Divider()
                            Spacer()
                        }
                        Divider()
                    }
                    
                    // Bars
                    HStack(spacing: 2) {
                        ForEach(randomNumbers.indices, id: \.self) { index in
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 3, height: randomNumbers[index] * 200)
                        }
                    }
                }
                .frame(height: 200)
                .padding(.horizontal, 10)  // Reduced padding inside graph area
                
                // Right y-axis
                YAxisView()
                
                // Right white space
                Color.white.frame(width: 20)
            }
            .padding()
            .background(Color.white)
            .overlay(
                Rectangle()
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(height: 250)
        }
    }
}

// Define the YAxisView struct
struct YAxisView: View {
    // Define the body of the view
    var body: some View {
        // Create a vertical stack for y-axis labels
        VStack {
            Text("1.0")
            Spacer()
            Text("0.5")
            Spacer()
            Text("0.0")
        }
        .frame(width: 40)
    }
}
