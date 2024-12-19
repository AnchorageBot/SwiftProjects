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

/// Main view of the application
/// Provides the primary user interface for the Bayesian calculator
struct ContentView: View {
    /// View model instance that manages the app's state and logic
    @StateObject private var calculator = ProbabilityCalculator()
    
    // State variables for controlling section expansion
    @State private var isInputExpanded = true
    @State private var isPriorExpanded = false
    @State private var isLikelihoodExpanded = false
    @State private var isPosteriorExpanded = false
    @State private var isVerificationExpanded = false
    
    /// The main view body
    /// Organizes content into collapsible sections with iOS native styling
    var body: some View {
        NavigationView {
            List {
                // MARK: About Section
                NavigationLink(destination: BayesianExplanationView()) {
                    Label("About Bayesian Analysis", systemImage: "info.circle")
                        .foregroundColor(.blue)
                }
                
                // MARK: Input Section
                Section {
                    DisclosureGroup(
                        isExpanded: $isInputExpanded,
                        content: {
                            ForEach($calculator.roomData) { $room in
                                RoomDataView(roomData: $room, isEditing: calculator.editMode == .active)
                            }
                        },
                        label: {
                            Text("INPUT DATA")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    )
                }
                
                // MARK: Prior Probabilities Section
                Section {
                    DisclosureGroup(
                        isExpanded: $isPriorExpanded,
                        content: {
                            ProbabilityRow(label: "P(B) Bedroom", value: calculator.results.priorB)
                            ProbabilityRow(label: "P(S) Study", value: calculator.results.priorS)
                        },
                        label: {
                            Text("PRIOR PROBABILITIES")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    )
                }
                
                // MARK: Likelihoods Section
                Section {
                    DisclosureGroup(
                        isExpanded: $isLikelihoodExpanded,
                        content: {
                            ProbabilityRow(label: "P(N|B) Noise given Bedroom", value: calculator.results.likelihoodNB)
                            ProbabilityRow(label: "P(N|S) Noise given Study", value: calculator.results.likelihoodNS)
                        },
                        label: {
                            Text("LIKELIHOODS")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    )
                }
                
                // MARK: Posterior Probabilities Section
                Section {
                    DisclosureGroup(
                        isExpanded: $isPosteriorExpanded,
                        content: {
                            ProbabilityRow(label: "P(B|N) Bedroom given Noise", value: calculator.results.posteriorBN)
                            ProbabilityRow(label: "P(S|N) Study given Noise", value: calculator.results.posteriorSN)
                        },
                        label: {
                            Text("POSTERIOR PROBABILITIES")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    )
                }
                
                // MARK: Verification Section
                Section {
                    DisclosureGroup(
                        isExpanded: $isVerificationExpanded,
                        content: {
                            ProbabilityRow(label: "P(N) Direct", value: calculator.results.pNDirect)
                            ProbabilityRow(label: "P(N) Calculated", value: calculator.results.pNCalculated)
                        },
                        label: {
                            Text("VERIFICATION")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        }
                    )
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
