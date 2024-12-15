//
// BayesCalculator
// ContentView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import SwiftUI

/// Main view of the application
struct ContentView: View {
    /// View model instance that manages the app's state and logic
    @StateObject private var calculator = ProbabilityCalculator()
    
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

#Preview {
    ContentView()
}
