// ContextView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the ContextView for the Monte Carlo Simulation app.
// It provides information about the Monte Carlo method used to estimate e,
// and displays the current estimated value if available.

import SwiftUI

// Define the context view
struct ContextView: View {
    // Binding to the estimated value of e
    @Binding var estimatedE: Double?
    
    // Define the body of the view
    var body: some View {
        // Create a scrollable view
        ScrollView {
            // Create a vertical stack with left alignment
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text("Estimating e using Monte Carlo Simulation")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Explanation of the app's purpose
                Text("This app uses the Monte Carlo method to estimate the mathematical constant e (Euler's number).")
                
                // Section header
                Text("How it works:")
                    .font(.headline)
                
                // Steps of the Monte Carlo method
                Text("1. We repeatedly perform the following experiment:")
                Text("   - Generate random numbers between 0 and 1")
                Text("   - Sum these numbers until the sum exceeds 1")
                Text("   - Count how many numbers were needed")
                
                Text("2. We repeat this experiment many times (default: 1,000,000 iterations)")
                
                Text("3. The average count of numbers needed across all experiments approximates e")
                
                // Additional information
                Text("The more iterations we perform, the more accurate our estimate becomes.")
                
                Text("Fun fact: The true value of e is approximately 2.71828.")
                
                // Display the current estimated value if available
                if let e = estimatedE {
                    Text("Current estimated value of e: \(e, specifier: "%.6f")")
                        .font(.headline)
                        .padding(.top)
                }
            }
            .padding()
        }
    }
}
