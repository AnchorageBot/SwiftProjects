//
// BayesCalculator
// CalculatorUsageView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//
//
// Abstract:
// This application implements a Bayesian probability calculator
// specifically designed to solve the phone location problem.
// It uses Bayes' Theorem to calculate the probability of a phone's
// location (Bedroom vs Study) based on noise observations.
// The app provides an intuitive interface for data input and
// displays calculated probabilities including priors, likelihoods,
// and posteriors.
//

import SwiftUI

/// View that provides instructions on how to use the calculator
/// Presents step-by-step guidance for users to operate the application
struct CalculatorUsageView: View {
    /// The main view body
    /// Displays ordered steps for using the calculator
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Use This Calculator")
                    .font(.title)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("1. Input or edit the observation counts for each room")
                    Text("2. The calculator automatically updates all probabilities")
                    Text("3. Review the results in different probability sections")
                    Text("4. Use the verification section to cross-check calculations")
                }
                .padding(.leading)
            }
            .padding()
        }
        .navigationTitle("Calculator Usage")
    }
}

/// Preview provider for CalculatorUsageView
struct CalculatorUsageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalculatorUsageView()
        }
        .previewDisplayName("Calculator Usage")
    }
}
