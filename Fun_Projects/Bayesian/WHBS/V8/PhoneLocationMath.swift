//
// BayesCalculator
// PhoneLocationMath.swift
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

/// View that explains the mathematical calculations for each probability type
/// Shows formulas and example calculations for the phone location problem
struct PhoneLocationMath: View {
    // State variables for controlling section expansion
    @State private var isPriorExpanded = false
    @State private var isLikelihoodExpanded = false
    @State private var isPosteriorExpanded = false
    @State private var isVerificationExpanded = false
    
    /// Observable object to access current probability values
    @StateObject private var calculator = ProbabilityCalculator()
    
    var body: some View {
        List {
            // Introduction section
            Section {
                Text("In this application, we're using Bayes' Theorem to solve a practical problem: determining the likely location of a phone based on noise observations.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            // Prior Probabilities Section
            Section {
                DisclosureGroup(
                    isExpanded: $isPriorExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Group {
                                Text("Formula:")
                                    .font(.headline)
                                Text("P(Location) = Location observations / Total observations")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Bedroom Prior:")
                                    .font(.headline)
                                Text("P(B) = 150 / 170 = 88.24%")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Study Prior:")
                                    .font(.headline)
                                Text("P(S) = 20 / 170 = 11.76%")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .padding(.vertical, 8)
                    },
                    label: {
                        Text("PRIOR PROBABILITIES")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                )
            }
            
            // Likelihoods Section
            Section {
                DisclosureGroup(
                    isExpanded: $isLikelihoodExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Group {
                                Text("Formula:")
                                    .font(.headline)
                                Text("P(N|Location) = Noise in location / Total in location")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Bedroom Likelihood:")
                                    .font(.headline)
                                Text("P(N|B) = 15 / 150 = 10.00%")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Study Likelihood:")
                                    .font(.headline)
                                Text("P(N|S) = 5 / 20 = 25.00%")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .padding(.vertical, 8)
                    },
                    label: {
                        Text("LIKELIHOODS")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                )
            }
            
            // Posterior Probabilities Section
            Section {
                DisclosureGroup(
                    isExpanded: $isPosteriorExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Group {
                                Text("Bayes' Theorem:")
                                    .font(.headline)
                                Text("P(Location|N) = P(N|Location) × P(Location) / P(N)")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Bedroom Posterior:")
                                    .font(.headline)
                                Text("P(B|N) = (0.10 × 0.8824) / 0.1176 = 75.00%")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Study Posterior:")
                                    .font(.headline)
                                Text("P(S|N) = (0.25 × 0.1176) / 0.1176 = 25.00%")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .padding(.vertical, 8)
                    },
                    label: {
                        Text("POSTERIOR PROBABILITIES")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                )
            }
            
            // Verification Section
            Section {
                DisclosureGroup(
                    isExpanded: $isVerificationExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Group {
                                Text("Direct Method:")
                                    .font(.headline)
                                Text("P(N) = Total noise / Total observations")
                                Text("P(N) = 20 / 170 = 11.76%")
                                    .font(.system(.body, design: .monospaced))
                            }
                            
                            Group {
                                Text("Law of Total Probability:")
                                    .font(.headline)
                                Text("P(N) = P(N|B)×P(B) + P(N|S)×P(S)")
                                Text("P(N) = 0.10×0.8824 + 0.25×0.1176 = 11.76%")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .padding(.vertical, 8)
                    },
                    label: {
                        Text("VERIFICATION")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                )
            }
        }
        .navigationTitle("Phone Location Math")
    }
}

#Preview {
    NavigationView {
        PhoneLocationMath()
    }
}
