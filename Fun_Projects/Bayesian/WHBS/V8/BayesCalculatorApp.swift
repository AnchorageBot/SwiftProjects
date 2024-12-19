//
// BayesCalculator
// BayesCalculatorApp.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
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

/// Main application entry point for the BayesCalculator app
/// Conforms to the App protocol to establish the SwiftUI app lifecycle
@main
struct BayesCalculatorApp: App {
    /// The root view of the application
    /// Creates a single window group containing the ContentView
    /// ContentView serves as the main interface for the calculator
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
