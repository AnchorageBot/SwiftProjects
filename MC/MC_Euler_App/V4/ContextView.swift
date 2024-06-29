// ContextView.swift

//
//  Created by ATS and Claude on 6/27/24
//  Made with Xcode 15.4
//

// Abstract:
// This file contains the ContextView for the Monte Carlo Simulation app.
// It provides information about the Monte Carlo method used to estimate e,
// displays both the classic and Monte Carlo formulas for e, and shows the current estimated value if available.
// The view is designed to educate users about the mathematical concept and the simulation process.

import SwiftUI

// Define the context view
struct ContextView: View {
    // Binding to the estimated value of e
    @Binding var estimatedE: Double?
    
    // Define the body of the view
    var body: some View {
        // Create a scrollable view
        ScrollView {
            // Create a vertical stack
            VStack(spacing: 20) {
                // Title, centered
                Text("Estimating e using Monte Carlo Simulation")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Classic formula for e
                FormulaView(
                    title: "Classic formula for e:",
                    formula: "e = lim(n→∞) (1 + 1/n)ⁿ",
                    explanation: "e is the limit of (1 + 1/n)ⁿ as n approaches infinity.",
                    color: .blue
                )
                /*
                // Monte Carlo formula for e
                FormulaView(
                    title: "Monte Carlo formula for e:",
                    formula: "e ≈ 1/N ∑ᴺⁱ₌₁ Xᵢ",
                    explanation: "N = Number of experiments\nXᵢ = Count of random numbers in experiment i",
                    color: .green
                )
                */
                
                // Monte Carlo formula for e
                FormulaView(
                    title: "Monte Carlo formula for e:",
                    formula: "e ≈ 1/N ∑ᴺᵢ₌₁ Xᵢ",
                    explanation: "N = Number of experiments\nXᵢ = Count of random numbers in experiment i",
                    color: .green
                )
                
                // Explanation of the app's purpose
                Text("App uses the Monte Carlo method to estimate e:")
                    .font(.headline)
                    .padding(.top)
                
                // Steps of the Monte Carlo method
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Generate random numbers between 0 and 1")
                    Text("2. Sum #s until > 1 and then count how many #s")
                    Text("3. Repeat experiment (default: 1,000,000 times)")
                    Text("4. Avg, #counts/#experiments, approximates e")
                }
                .padding(.horizontal)
                                
                // Display the current estimated value if available
                if let e = estimatedE {
                    Text("Current estimate: \(e, specifier: "%.6f")")
                        .font(.headline)
                        .padding()
                        .background(Color.yellow.opacity(0.2))
                        .cornerRadius(10)
                }
                
                Text("True value of e ≈ 2.7182818 ...")
                    .font(.subheadline)
                    .italic()
                    .padding(.top, 5)
            }
            .padding()
        }
    }
}

// Helper view for displaying formulas
struct FormulaView: View {
    let title: String
    let formula: String
    let explanation: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            Text(formula)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
            Text(explanation)
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.1))
        .cornerRadius(10)
    }
}
