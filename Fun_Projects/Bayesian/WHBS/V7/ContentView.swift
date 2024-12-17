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

/// Main view of the application
/// Provides the primary user interface for the Bayesian calculator
struct ContentView: View {
    /// View model instance that manages the app's state and logic
    /// Handles all probability calculations and data management
    @StateObject private var calculator = ProbabilityCalculator()
    
    /// The main view body
    /// Organizes content into a navigable list with multiple sections
    var body: some View {
        NavigationView {
            List {
                // MARK: About Section
                Section {
                    NavigationLink(destination: BayesianExplanationView()) {
                        Label("About Bayesian Analysis", systemImage: "info.circle")
                    }
                }
                
                // MARK: Input Section
                Section(header: Text("Input Data")) {
                    ForEach($calculator.roomData) { $room in
                        RoomDataView(roomData: $room, isEditing: calculator.editMode == .active)
                    }
                }
                
                // MARK: Results Sections
                Section(header: Text("Prior Probabilities")) {
                    ProbabilityRow(label: "P(B) Bedroom", value: calculator.results.priorB)
                    ProbabilityRow(label: "P(S) Study", value: calculator.results.priorS)
                }
                
                Section(header: Text("Likelihoods")) {
                    ProbabilityRow(label: "P(N|B) Noise given Bedroom", value: calculator.results.likelihoodNB)
                    ProbabilityRow(label: "P(N|S) Noise given Study", value: calculator.results.likelihoodNS)
                }
                
                Section(header: Text("Posterior Probabilities")) {
                    ProbabilityRow(label: "P(B|N) Bedroom given Noise", value: calculator.results.posteriorBN)
                    ProbabilityRow(label: "P(S|N) Study given Noise", value: calculator.results.posteriorSN)
                }
                
                Section(header: Text("Verification")) {
                    ProbabilityRow(label: "P(N) Direct", value: calculator.results.pNDirect)
                    ProbabilityRow(label: "P(N) Calculated", value: calculator.results.pNCalculated)
                }
            }
            .navigationTitle("Probability Calculator")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $calculator.editMode)
            .alert("Invalid Input", isPresented: $calculator.showValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please ensure all values are valid numbers greater than or equal to 0.")
            }
        }
    }
}

/// Preview provider for ContentView
#Preview {
    ContentView()
}
