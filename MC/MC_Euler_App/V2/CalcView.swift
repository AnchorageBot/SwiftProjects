// CalcView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the CalcView for the Monte Carlo Simulation app.
// It provides a calculator for compound interest using the estimated value of e.
// Users can input initial savings and time period to calculate the final amount.

import SwiftUI

// Define the calculation view
struct CalcView: View {
    // State variables for user input
    @State private var savings: String = ""
    @State private var years: String = ""
    // State variable for the calculation result
    @State private var result: Double?
    // Binding to the estimated value of e
    @Binding var estimatedE: Double?
    
    // Define the body of the view
    var body: some View {
        // Create a scrollable view
        ScrollView {
            // Create a vertical stack
            VStack(spacing: 20) {
                // Title
                Text("Compound Interest Calculator")
                    .font(.title)
                    .padding()
                
                // Input field for initial savings
                TextField("Initial Savings ($)", text: $savings)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Input field for time period
                TextField("Time Period (years)", text: $years)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Button to calculate interest
                Button(action: calculateInterest) {
                    Text("Calculate Interest")
                        .padding()
                        .background(Color.green.opacity(0.5))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                
                // Display the result if available
                if let result = result {
                    Text("Final Amount: $\(result, specifier: "%.2f")")
                        .font(.title2)
                        .padding()
                }
                
                // Section for compound interest equation
                Text("Compound Interest Equation:")
                    .font(.headline)
                    .padding(.top)
                
                // Display the equation and its components
                VStack(alignment: .leading, spacing: 10) {
                    Text("A = P * e^(r * t)")
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                    Text("Where:")
                    Text("A = Final Amount")
                    Text("P = Principal (Initial Savings)")
                    Text("e = Euler's number (estimated)")
                    Text("r = Annual Interest Rate")
                    Text("t = Time Period (in years)")
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
    }
    
    // Function to calculate compound interest
    private func calculateInterest() {
        // Ensure all required values are available
        guard let principal = Double(savings),
              let time = Double(years),
              let e = estimatedE else {
            return
        }
        
        // Set the annual interest rate (5% in this example)
        let rate = 0.05
        // Calculate the final amount using the compound interest formula
        let amount = principal * pow(e, rate * time)
        // Store the result
        result = amount
    }
}
