//
// ETF_v2
// ETFInputView.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
//

import SwiftUI

struct ETFInputView: View {
    @Binding var etfInput: ETFInput // Use binding to allow modifications

    // numberFormatter can remain as is, or be removed if direct string input is preferred
    // For simplicity with direct string properties in ETFInput, we are not using it directly in TextFields here
    // but ensuring .keyboardType(.decimalPad) helps. Validation is done via computed properties.

    var body: some View {
        VStack(alignment: .leading, spacing: 15) { // Increased spacing for clarity
            
            // ETF Name
            Text("ETF Name")
                .font(.caption).foregroundColor(.secondary)
            TextField("e.g., VTI, QQQ", text: $etfInput.name)

            // Expense Ratio & Annual Yield in an HStack, but each with its own VStack for label + field
            HStack(alignment: .top, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Expense Ratio (%)")
                        .font(.caption).foregroundColor(.secondary)
                    TextField("e.g., 0.03", text: $etfInput.expenseRatioPercentString)
                        .keyboardType(.decimalPad)
                }
                VStack(alignment: .leading) {
                    Text("Annual Yield (%)")
                        .font(.caption).foregroundColor(.secondary)
                    TextField("e.g., 1.5", text: $etfInput.annualYieldPercentString)
                        .keyboardType(.decimalPad)
                }
            }

            // Shares & Start Price in an HStack, similar structure
            HStack(alignment: .top, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Shares")
                        .font(.caption).foregroundColor(.secondary)
                    TextField("e.g., 10", text: $etfInput.sharesString)
                        .keyboardType(.decimalPad)
                }
                VStack(alignment: .leading) {
                    Text("Start Price ($)")
                        .font(.caption).foregroundColor(.secondary)
                    TextField("e.g., 206.55", text: $etfInput.startPriceString)
                        .keyboardType(.decimalPad)
                }
            }
            
            // Purchase Date
            DatePicker("Purchase Date", selection: $etfInput.startDate, displayedComponents: .date)
                .padding(.top, 5) // Add some top padding if elements are too close

            // Current/Analysis Price
            Text("Current/Analysis Price ($)")
                .font(.caption).foregroundColor(.secondary)
            TextField("e.g., 286.77", text: $etfInput.endPriceString)
                .keyboardType(.decimalPad)
            
            // Analysis Date
            DatePicker("Analysis Date", selection: $etfInput.endDate, displayedComponents: .date)
                .padding(.top, 5)


            // Validation Hint (slightly more descriptive)
            if !etfInput.name.isEmpty && !etfInput.isValid {
                 Text("Please ensure all fields are filled correctly: numbers are valid, ETF name is present, and end date is not before start date.")
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.top, 3)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        // .padding(.vertical, 5) // Add a little vertical padding inside the Vstack if needed
    }
}
