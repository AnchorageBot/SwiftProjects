//
//  GlossaryView.swift
//  MonteCarloStock
//
//  Created by ATS and Claude on 6/29/24
//  Made with Xcode 15.4
//

// Abstract:
// This file defines a GlossaryView for the Monte Carlo Stock Price Simulation app.
// It presents a list of five key terms related to stock price simulation and financial modeling.
// Each term can be expanded to show its definition, and then collapsed again.
// The view uses SwiftUI to create an interactive, user-friendly glossary interface,
// with accessibility considerations for VoiceOver users.

import SwiftUI

// Define a structure to represent a glossary term
struct GlossaryTerm: Identifiable {
    let id = UUID()  // Unique identifier for each term
    let term: String  // The term itself
    let definition: String  // The definition of the term
}

struct GlossaryView: View {
    // Array of glossary terms
    let terms = [
        GlossaryTerm(term: "Monte Carlo Simulation",
                     definition: "A statistical technique that uses random sampling and statistical modeling to estimate the probability of different outcomes in a process that cannot easily be predicted due to the intervention of random variables."),
        GlossaryTerm(term: "Volatility",
                     definition: "A statistical measure of the dispersion of returns for a given security or market index. In the context of stock prices, it refers to the amount of uncertainty or risk about the size of changes in a stock's value."),
        GlossaryTerm(term: "Drift",
                     definition: "In finance, drift refers to the average expected return of an asset over time. It's often represented as the expected annual return in stock price models."),
        GlossaryTerm(term: "Geometric Brownian Motion",
                     definition: "A continuous-time stochastic process used in mathematical finance to model stock prices. It assumes that the percentage change in the stock price follows a normal distribution."),
        GlossaryTerm(term: "Confidence Interval",
                     definition: "A range of values that is likely to contain an unknown population parameter. In the context of stock price simulation, it provides a range of possible future stock prices with a certain level of confidence.")
    ]
    
    // State variable to track which terms are expanded
    @State private var expandedTerms: Set<UUID> = []
    
    var body: some View {
        NavigationView {
            List {
                // Iterate over each term in the glossary
                ForEach(terms) { term in
                    VStack(alignment: .leading) {
                        // Term header (always visible)
                        HStack {
                            Text(term.term)
                                .font(.headline)
                            Spacer()
                            // Expand/collapse button
                            Button(action: {
                                toggleExpansion(for: term)
                            }) {
                                Image(systemName: isExpanded(term) ? "chevron.up" : "chevron.down")
                            }
                            .accessibilityLabel(isExpanded(term) ? "Collapse definition" : "Expand definition")
                        }
                        .accessibilityAddTraits(.isButton)
                        .accessibilityHint("Double tap to \(isExpanded(term) ? "collapse" : "expand") the definition")
                        
                        // Term definition (visible when expanded)
                        if isExpanded(term) {
                            Text(term.definition)
                                .font(.body)
                                .padding(.top, 5)
                                .accessibilityLabel("Definition: \(term.definition)")
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("Glossary")
        }
    }
    
    // Function to check if a term is expanded
    private func isExpanded(_ term: GlossaryTerm) -> Bool {
        expandedTerms.contains(term.id)
    }
    
    // Function to toggle the expansion state of a term
    private func toggleExpansion(for term: GlossaryTerm) {
        if isExpanded(term) {
            expandedTerms.remove(term.id)
        } else {
            expandedTerms.insert(term.id)
        }
    }
}

// Preview provider for SwiftUI canvas
struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
