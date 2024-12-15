//
// BayesCalculator
// CalculatorUsageView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import SwiftUI

struct CalculatorUsageView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Use This Calculator")
                    .font(.title)
                    .padding(.bottom, 5)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("1. Input or edit the observation counts for each room")
                    Text("2. The calculator automatically updates all probabilities")
                    Text("3. Review the results in different probability sections")
                    Text("4. Use the verification section to cross-check calculations")
                }
                .padding(.leading)
            }
            .padding()
        }
        .navigationTitle("Calculator Usage")
    }
}

struct CalculatorUsageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalculatorUsageView()
        }
        .previewDisplayName("Calculator Usage")
    }
}
