// ContentView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the main view of the Monte Carlo Simulation app.
// It manages the UI for running simulations, displaying results, and showing context information.
// The view includes navigation between different sections and a visualization of random numbers.

import SwiftUI

// Define the main content view
struct ContentView: View {
    // State variable to track the current view
    @State private var currentView = "simulation"
    // State variable to store the estimated value of e
    @State private var estimatedE: Double?
    // State variable to store random numbers for visualization
    @State private var randomNumbers: [CGFloat] = Array(repeating: 0, count: 100)
    
    // Define the body of the view
    var body: some View {
        // Create a vertical stack
        VStack {
            // Switch between different views based on currentView state
            switch currentView {
            case "context":
                // Show the context view
                ContextView(estimatedE: $estimatedE)
            case "calculate":
                // Show the calculation view
                CalcView(estimatedE: $estimatedE)
            default:
                // Show the simulation view
                SimulationView(estimatedE: estimatedE, randomNumbers: randomNumbers)
            }
            
            // Create a horizontal stack for navigation buttons
            HStack {
                // Simulate button
                NavigationButton(currentView: $currentView, destination: "simulation", text: "Simulate", color: .blue) {
                    runSimulation()
                }
                // Context button
                NavigationButton(currentView: $currentView, destination: "context", text: "Context", color: Color.green.opacity(0.5))
                // Calculate button
                NavigationButton(currentView: $currentView, destination: "calculate", text: "Calculate", color: .green)
            }
            .padding()
        }
    }
    
    // Function to run the Monte Carlo simulation
    private func runSimulation() {
        // Create a new simulation instance
        let simulation = MonteCarloSimulation()
        // Estimate e and store the result
        self.estimatedE = simulation.estimateE(iterations: 1_000_000)
        // Generate random numbers for visualization
        self.randomNumbers = simulation.getVisualizationNumbers(count: 100)
    }
}

// Define a custom navigation button
struct NavigationButton: View {
    // Binding to the current view state
    @Binding var currentView: String
    // Destination view for this button
    let destination: String
    // Text to display on the button
    let text: String
    // Color of the button
    let color: Color
    // Optional action to perform when pressed
    var action: (() -> Void)? = nil
    
    // Define the body of the button
    var body: some View {
        // Create a button
        Button(action: {
            // Set the current view to the destination
            currentView = destination
            // Perform the action if it exists
            action?()
        }) {
            // Style the button
            Text(text)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

// Define the simulation view
struct SimulationView: View {
    // Estimated value of e
    let estimatedE: Double?
    // Random numbers for visualization
    let randomNumbers: [CGFloat]
    
    // Define the body of the view
    var body: some View {
        // Create a vertical stack
        VStack {
            // Display the estimated value of e or a prompt
            if let e = estimatedE {
                Text("Estimated value of e: \(e, specifier: "%.6f")")
                    .font(.title)
                    .padding()
            } else {
                Text("Press 'Simulate' to estimate e")
                    .font(.title)
                    .padding()
            }
            
            // Create a horizontal stack for the graph
            HStack(spacing: 0) {
                // Add y-axis on the left
                YAxisView()
                
                // Create a ZStack for the graph
                ZStack(alignment: .bottom) {
                    // Background grid
                    VStack(spacing: 0) {
                        ForEach(0..<5) { _ in
                            Divider()
                            Spacer()
                        }
                        Divider()
                    }
                    
                    // Bars representing random numbers
                    HStack(spacing: 2) {
                        ForEach(randomNumbers.indices, id: \.self) { index in
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 3, height: randomNumbers[index] * 200)
                        }
                    }
                }
                .frame(height: 200)
                .padding(.horizontal, 10)
                
                // Add y-axis on the right
                YAxisView()
            }
            .padding()
            .background(Color.white)
            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            .frame(height: 250)
        }
    }
}

// Define the y-axis view
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
