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

/// Provides educational content about Bayesian probability and the phone location problem
struct BayesianExplanationView: View {
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
                
                // MARK: - Phone Location Problem
                Group {
                    Text("Our Phone Location Problem")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("In this application, we're using Bayes' Theorem to solve a practical problem: determining the likely location of a phone based on noise observations.")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("The Variables:")
                            .font(.subheadline)
                        Text("• Locations: Bedroom (B) and Study (S)")
                        Text("• Evidence: Noise (N) or No Noise")
                        Text("• P(B|N): Probability phone is in Bedroom given Noise")
                        Text("• P(N|B): Probability of Noise given phone is in Bedroom")
                    }
                    .padding(.leading)
                }
                
                // MARK: - How to Use
                Group {
                    Text("How to Use This Calculator")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("1. Input or edit the observation counts for each room")
                    Text("2. The calculator automatically updates all probabilities")
                    Text("3. Review the results in different probability sections")
                    Text("4. Use the verification section to cross-check calculations")
                        .padding(.leading)
                }
                
                // MARK: - Practical Example
                Group {
                    Text("Practical Example")
                        .font(.headline)
                        .padding(.top)
                    
                    Text("If we observe 15 instances of noise in the bedroom out of 150 total bedroom observations, and 5 instances of noise in the study out of 20 total study observations, the calculator will show:")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("• Different prior probabilities for each room")
                    Text("• Likelihood of noise in each location")
                    Text("• Updated (posterior) probabilities after observing noise")
                        .padding(.leading)
                }
            }
            .padding()
        }
        .navigationTitle("About Bayesian Analysis")
    }
}

#Preview {
    NavigationView {
        BayesianExplanationView()
    }
}
