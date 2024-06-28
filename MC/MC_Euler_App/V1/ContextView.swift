
//  ContextView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the ContextView, which provides information about the Monte Carlo simulation.
// It explains how the app estimates e and includes a button to run the simulation.
// The view is designed to educate users about the mathematical concept and the simulation process.

import SwiftUI

struct ContextView: View {
    // Binding to control the visibility of this view
    @Binding var showingContext: Bool
    
    // Closure to run the simulation
    let runSimulation: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title of the context view
                Text("Estimating e using Monte Carlo Simulation")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Explanation of the app's purpose
                Text("This app uses the Monte Carlo method to estimate the mathematical constant e (Euler's number).")
                
                // Header for the explanation of how it works
                Text("How it works:")
                    .font(.headline)
                
                // Step-by-step explanation of the Monte Carlo method
                Text("1. We repeatedly perform the following experiment:")
                Text("   - Generate random numbers between 0 and 1")
                Text("   - Sum these numbers until the sum exceeds 1")
                Text("   - Count how many numbers were needed")
                
                Text("2. We repeat this experiment many times (default: 1,000,000 iterations)")
                
                Text("3. The average count of numbers needed across all experiments approximates e")
                
                // Additional information about the accuracy of the estimation
                Text("The more iterations we perform, the more accurate our estimate becomes.")
                
                // Interesting fact about e
                Text("Fun fact: The true value of e is approximately 2.71828.")
                
                // Button to run the simulation and return to the main view
                Button(action: {
                    runSimulation()
                    showingContext = false
                }) {
                    Text("Run Simulation")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
    }
}
