//
// BayesCalculator
// BayesianExplanationView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import SwiftUI

/// View that provides educational content about Bayesian probability
/// Explains Bayes' Theorem, its formula, and provides navigation to related topics
/// This view serves as the main educational resource in the application
struct BayesianExplanationView: View {
    /// The main view body
    /// Organizes content into a scrollable view with consistent typography and spacing
    var body: some View {
        ScrollView {
            // Main content container with consistent left alignment and spacing
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Title Section
                Text("Understanding Bayesian Probability")
                    .font(.title2)
                    .padding(.bottom, 5)
                
                // MARK: - Theorem Explanation Section
                Group {
                    Text("What is Bayes' Theorem?")
                        .font(.headline)
                    
                    // Basic explanation of Bayes' Theorem and its utility
                    Text("Bayes' Theorem is a fundamental principle in probability theory that describes how to update the probability of a hypothesis based on new evidence. It's particularly useful when we want to reverse conditional probabilities.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // MARK: - Formula Section
                Group {
                    // Formula header
                    Text("The Formula")
                        .font(.headline)
                    
                    // Bayes' Theorem formula with monospaced font for clarity
                    Text("P(A|B) = P(B|A) × P(A) / P(B)")
                        .font(.system(.body, design: .monospaced))
                        .padding(.vertical, 8)
                    
                    // Variable definitions header
                    Text("Where:")
                        .font(.headline)
                    
                    // List of variable definitions with consistent spacing
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• P(A|B) is the posterior probability")
                        Text("• P(B|A) is the likelihood")
                        Text("• P(A) is the prior probability")
                        Text("• P(B) is the evidence")
                    }
                }
                .padding(.bottom, 8)
                
                // MARK: - Navigation Links Section
                // Container for navigation links with consistent spacing
                VStack(alignment: .leading, spacing: 24) {
                    // Navigation to calculator usage instructions
                    NavigationLink(destination: CalculatorUsageView()) {
                        Text("How to Use This Calculator")
                            .font(.headline)
                            .foregroundColor(.accentColor)  // Uses system blue color
                    }
                    
                    // Navigation to problem-specific explanation
                    NavigationLink(destination: PhoneLocationProblemView()) {
                        Text("Phone Location Problem")
                            .font(.headline)
                            .foregroundColor(.accentColor)  // Uses system blue color
                    }
                    
                    // Navigation to mathematical details
                    NavigationLink(destination: PhoneLocationMath()) {
                        Text("Phone Location Math")
                            .font(.headline)
                            .foregroundColor(.accentColor)  // Uses system blue color
                    }
                }
            }
            .padding()  // Adds consistent padding around all content
        }
        .navigationTitle("About Bayesian Analysis")  // Sets the navigation bar title
    }
}

/// Preview provider for BayesianExplanationView
/// Wraps the view in a NavigationView for proper preview rendering
#Preview {
    NavigationView {
        BayesianExplanationView()
    }
}
