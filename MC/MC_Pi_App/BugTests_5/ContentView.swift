//
//  ContentView.swift
//  MonteCarloPi
//
//  Created by ATS and Claude on 6/25/24
//  Made with Xcode 15.4
//
// Abstract:
// This file enhances the ContentView with accessibility features,
// focusing on VoiceOver compatibility. It adds accessibility labels,
// hints, and traits to key UI elements to improve the app's usability
// for users with disabilities.

import SwiftUI
import Charts

struct ContentView: View {
    @State private var piEstimate: Double = 0
    @State private var points: [Point] = []
    @State private var showingContext = false
    
    var body: some View {
        VStack {
            if showingContext {
                ContextView()
            } else {
                // Display the estimated value of pi
                Text("Estimated value of π: \(piEstimate, specifier: "%.5f")")
                    .accessibilityLabel("Estimated value of pi")
                    .accessibilityValue(String(format: "%.5f", piEstimate))
                
                // Create a scatter plot of the generated points
                Chart {
                    ForEach(points, id: \.x) { point in
                        PointMark(
                            x: .value("X", point.x),
                            y: .value("Y", point.y)
                        )
                        .foregroundStyle(point.x*point.x + point.y*point.y <= 1 ? .blue : .red)
                    }
                }
                .frame(width: 300, height: 300)
                .overlay(
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width: 300, height: 300)
                )
                .accessibilityLabel("Monte Carlo simulation scatter plot")
                .accessibilityHint("A visual representation of the points used in the Pi estimation")
                
                // Button to trigger the simulation
                Button("Run Simulation") {
                    let result = estimatePi(numberOfPoints: 10000)
                    piEstimate = result.0
                    points = result.1
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .accessibilityHint("Runs the Monte Carlo simulation to estimate Pi")
            }
            
            // Button to toggle between simulation view and context view
            Button(showingContext ? "Show Simulation" : "Simulation Context") {
                showingContext.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .accessibilityHint(showingContext ? "Returns to the simulation view" : "Shows information about the Monte Carlo method")
        }
    }
}
