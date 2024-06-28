
// ContentView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the main view of the Monte Carlo Simulation app.
// It manages the UI for running simulations, displaying results, and showing context information.
// The view includes a visualization of random numbers with y-axes and buttons for user interaction.

import SwiftUI

struct ContentView: View {
    @State private var showingContext = false
    @State private var estimatedE: Double?
    @State private var randomNumbers: [CGFloat] = Array(repeating: 0, count: 100)
    
    var body: some View {
        VStack {
            if showingContext {
                ContextView(showingContext: $showingContext, runSimulation: runSimulation)
            } else {
                SimulationView(estimatedE: estimatedE, randomNumbers: randomNumbers)
                
                Button(action: runSimulation) {
                    Text("Run Simulation")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
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
    
    private func runSimulation() {
        let simulation = MonteCarloSimulation()
        self.estimatedE = simulation.estimateE(iterations: 1_000_000)
        self.randomNumbers = simulation.getVisualizationNumbers(count: 100)
        self.showingContext = false
    }
}

struct SimulationView: View {
    let estimatedE: Double?
    let randomNumbers: [CGFloat]
    
    var body: some View {
        VStack {
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

struct YAxisView: View {
    var body: some View {
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
