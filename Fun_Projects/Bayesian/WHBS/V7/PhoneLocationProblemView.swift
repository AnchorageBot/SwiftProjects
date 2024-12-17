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

/// View that explains the phone location problem
/// Provides context and explanation for the practical application
/// of Bayes' Theorem in the app
struct PhoneLocationProblemView: View {
    /// The main view body
    /// Displays explanation of the phone location problem and variables
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

/// Preview provider for PhoneLocationProblemView
struct PhoneLocationProblemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhoneLocationProblemView()
        }
        .previewDisplayName("Phone Location Problem")
    }
}
