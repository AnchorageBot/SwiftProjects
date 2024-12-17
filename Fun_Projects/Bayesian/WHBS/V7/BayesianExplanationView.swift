//===------------------------------------------------===//
// BayesCalculator
// A SwiftUI application for Bayesian probability analysis
//===------------------------------------------------===//
// Version: 1.0
// Swift Version: 6.0
// Created: December 12, 2024
//
// Abstract:
// This application implements a Bayesian probability calculator
// specifically designed to solve the phone location problem.
// It uses Bayes' Theorem to calculate the probability of a phone's
// location (Bedroom vs Study) based on noise observations.
// The app provides an intuitive interface for data input and
// displays calculated probabilities including priors, likelihoods,
// and posteriors.
//===------------------------------------------------===//

import SwiftUI

/// View that provides educational content about Bayesian probability
/// Explains Bayes' Theorem and its application in the app's context
struct BayesianExplanationView: View {
    /// The main view body
    /// Organizes content into scrollable sections with educational material
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Title Section
                Text("Understanding Bayesian Probability")
                    .font(.title)
                    .padding(.bottom, 5)
                
                // MARK: - Introduction
                Group {
                    Text("What is Bayes' Theorem?")
                        .font(.headline)
                    
                    Text("Bayes' Theorem is a fundamental principle in probability theory that describes how to update the probability of a hypothesis based on new evidence. It's particularly useful when we want to reverse conditional probabilities.")
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // MARK: - Formula Section
                Group {
                    Text("The Formula")
                        .font(.headline)
                    
                    Text("P(A|B) = P(B|A) × P(A) / P(B)")
                        .font(.system(.body, design: .monospaced))
                        .padding()
                    
                    Text("Where:")
                        .font(.subheadline)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("• P(A|B) is the posterior probability")
                        Text("• P(B|A) is the likelihood")
                        Text("• P(A) is the prior probability")
                        Text("• P(B) is the evidence")
                    }
                    .padding(.leading)
                }
                
                // MARK: - Navigation Links
                VStack(spacing: 15) {
                    NavigationLink(destination: CalculatorUsageView()) {
                        Text("How to Use This Calculator")
                            .font(.headline)
                    }
                    
                    NavigationLink(destination: PhoneLocationProblemView()) {
                        Text("Phone Location Problem")
                            .font(.headline)
                    }
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("About Bayesian Analysis")
    }
}

/// Preview provider for BayesianExplanationView
struct BayesianExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BayesianExplanationView()
        }
        .previewDisplayName("Bayesian Explanation")
    }
}
