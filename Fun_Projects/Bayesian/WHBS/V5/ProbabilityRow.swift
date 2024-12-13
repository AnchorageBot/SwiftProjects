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

import SwiftUI

/// Reusable view for displaying a probability value with its label
struct ProbabilityRow: View {
    /// Label describing the probability being displayed
    let label: String
    /// Probability value to display (0-1 range)
    let value: Double
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(FormattingHelpers.probabilityAsPercentage(value))
        }
    }
}
