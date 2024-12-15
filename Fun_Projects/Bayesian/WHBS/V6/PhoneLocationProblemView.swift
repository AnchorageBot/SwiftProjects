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

import SwiftUI

struct PhoneLocationProblemView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
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
            }
            .padding()
        }
        .navigationTitle("Phone Location Problem")
    }
}

struct PhoneLocationProblemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhoneLocationProblemView()
        }
        .previewDisplayName("Phone Location Problem")
    }
}
