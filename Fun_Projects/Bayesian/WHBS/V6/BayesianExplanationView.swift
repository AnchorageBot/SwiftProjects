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

struct BayesianExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BayesianExplanationView()
        }
        .previewDisplayName("Bayesian Explanation")
    }
}
