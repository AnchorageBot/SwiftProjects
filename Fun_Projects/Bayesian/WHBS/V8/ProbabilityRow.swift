//
// BayesCalculator
// ProbabilityRow.swift
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

/// Reusable view for displaying a probability value with its label
/// This view provides a consistent layout for showing probability values
/// throughout the application, formatting the probability as a percentage
struct ProbabilityRow: View {
    /// Label describing the probability being displayed
    /// Example: "P(B) Bedroom" or "P(N|B) Noise given Bedroom"
    let label: String
    
    /// Probability value to display (0-1 range)
    /// Will be formatted as a percentage in the view
    let value: Double
    
    /// The view's body
    /// Displays the label and formatted probability value in a horizontal layout
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(FormattingHelpers.probabilityAsPercentage(value))
        }
    }
}
