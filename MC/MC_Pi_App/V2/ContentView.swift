//
//  ContentView.swift
//  MonteCarloPi
//
//  Created by ATS and Claude on 6/25/24
//  Made with Xcode 15.4
//

// Abstract:
// This Swift script demonstrates a Monte Carlo simulation to estimate the value of pi.
// It uses random point generation within a 1x1 square and determines the ratio of points
// falling inside a quarter circle to the total number of points. The result is visualized
// using SwiftUI and Charts, showing the estimated value of pi and a scatter plot of the points.

import Foundation
import SwiftUI
import Charts

// Struct to represent a 2D point
struct Point {
    let x: Double
    let y: Double
}

// Function to estimate pi using Monte Carlo method
func estimatePi(numberOfPoints: Int) -> (Double, [Point]) {
    var pointsInsideCircle = 0
    var points: [Point] = []
    
    // Generate random points and check if they fall inside the quarter circle
    for _ in 0..<numberOfPoints {
        let x = Double.random(in: 0...1)
        let y = Double.random(in: 0...1)
        let point = Point(x: x, y: y)
        points.append(point)
        
        // Check if the point is inside the quarter circle
        if x*x + y*y <= 1 {
            pointsInsideCircle += 1
        }
    }
    
    // Calculate the estimate of pi
    let piEstimate = 4.0 * Double(pointsInsideCircle) / Double(numberOfPoints)
    return (piEstimate, points)
}

// SwiftUI view to display the simulation results
struct ContentView: View {
    // State variables to hold the estimated pi value and generated points
    @State private var piEstimate: Double = 0
    @State private var points: [Point] = []
    // State variable to control which view is shown
    @State private var showingContext = false
    
    var body: some View {
        VStack {
            if showingContext {
                // Show the ContextView when showingContext is true
                ContextView()
            } else {
                // Display the estimated value of pi
                Text("Estimated value of π: \(piEstimate, specifier: "%.5f")")
                
                // Create a scatter plot of the generated points
                Chart {
                    ForEach(points, id: \.x) { point in
                        PointMark(
                            x: .value("X", point.x),
                            y: .value("Y", point.y)
                        )
                        // Color points based on whether they're inside or outside the circle
                        .foregroundStyle(point.x*point.x + point.y*point.y <= 1 ? .blue : .red)
                    }
                }
                .frame(width: 300, height: 300)
                // Overlay a circle to represent the quarter circle boundary
                .overlay(
                    Circle()
                        .stroke(Color.green, lineWidth: 2)
                        .frame(width: 300, height: 300)
                )
                
                // Button to trigger the simulation (in blue)
                Button("Run Simulation") {
                    let result = estimatePi(numberOfPoints: 10000)
                    piEstimate = result.0
                    points = result.1
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Button to toggle between simulation view and context view (in red)
            Button(showingContext ? "Show Simulation" : "Simulation Context") {
                showingContext.toggle()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
