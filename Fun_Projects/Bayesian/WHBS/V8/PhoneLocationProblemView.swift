//
// BayesCalculator
// PhoneLocationProblemView.swift
//
// Created on 12/14/24
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

/// View that explains the phone location problem
struct PhoneLocationProblemView: View {
    // State variables for controlling section expansion
    @State private var isPriorExpanded = false
    @State private var isLikelihoodExpanded = false
    @State private var isPosteriorExpanded = false
    @State private var isVerificationExpanded = false
    
    var body: some View {
        List {
            Section {
                Text("In this application, we're using Bayes' Theorem to solve a practical problem: determining the likely location of a phone based on noise observations.")
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Section {
                DisclosureGroup(
                    isExpanded: $isPriorExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Prior probabilities represent our initial beliefs about where the phone might be, before considering any noise evidence:")
                            Text("• P(B): Probability the phone is in the Bedroom")
                            Text("• P(S): Probability the phone is in the Study")
                            Text("\nThese are calculated based on historical data of where the phone has been found.")
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
            
            Section {
                DisclosureGroup(
                    isExpanded: $isLikelihoodExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Likelihoods show how probable noise is in each location:")
                            Text("• P(N|B): Probability of hearing noise when the phone is in the Bedroom")
                            Text("• P(N|S): Probability of hearing noise when the phone is in the Study")
                            Text("\nThis is based on historical observations of noise patterns in each room.")
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
            
            Section {
                DisclosureGroup(
                    isExpanded: $isPosteriorExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Posterior probabilities are our updated beliefs after hearing noise:")
                            Text("• P(B|N): Probability the phone is in the Bedroom, given we heard noise")
                            Text("• P(S|N): Probability the phone is in the Study, given we heard noise")
                            Text("\nThese are calculated using Bayes' Theorem to combine prior probabilities with likelihoods.")
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
            
            Section {
                DisclosureGroup(
                    isExpanded: $isVerificationExpanded,
                    content: {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Verification shows two ways of calculating P(N):")
                            Text("• Direct: Total noise observations divided by total observations")
                            Text("• Calculated: Using the Law of Total Probability:")
                            Text("  P(N) = P(N|B)×P(B) + P(N|S)×P(S)")
                            Text("\nThese should match, verifying our calculations.")
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
        .navigationTitle("Phone Location Problem")
    }
}

#Preview {
    NavigationView {
        PhoneLocationProblemView()
    }
}
