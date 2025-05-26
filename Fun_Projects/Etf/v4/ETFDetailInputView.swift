//
// ETF_v3
// ETFDetailInputView.swift
//
// Created on 5/23/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import SwiftUI

// MARK: - ETF Detail Input View
/// Detailed input form for a single ETF
/// Provides all fields needed to configure an ETF investment
struct ETFDetailInputView: View {
    // MARK: - Properties
    /// Binding to the ETF input data model
    /// Changes here directly update the parent's data
    @Binding var etfInput: ETFInput
    
    /// The ETF number for display purposes (1-based index)
    let etfNumber: Int
    
    /// Environment value to dismiss this view
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        // Form provides grouped input fields with appropriate styling
        Form {
            // MARK: Basic Information Section
            Section {
                HStack {
                    Text("ETF Name")
                        .foregroundColor(.secondary)
                    Spacer()
                    // Text field for ETF ticker/name
                    TextField("e.g., VTI, QQQ", text: $etfInput.name)
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                Text("Basic Information")
            }
            
            // MARK: Performance Metrics Section
            Section {
                // Expense Ratio Input
                HStack {
                    Text("Expense Ratio")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("0.03", text: $etfInput.expenseRatioPercentString)
                        .keyboardType(.decimalPad) // Numeric keyboard
                        .multilineTextAlignment(.trailing)
                        .frame(width: 80) // Fixed width for better alignment
                    Text("%")
                        .foregroundColor(.secondary)
                }
                
                // Annual Yield Input
                HStack {
                    Text("Annual Yield")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("1.5", text: $etfInput.annualYieldPercentString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 80)
                    Text("%")
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("Performance Metrics")
            }
            
            // MARK: Purchase Details Section
            Section {
                // Number of Shares
                HStack {
                    Text("Number of Shares")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("10", text: $etfInput.sharesString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 100)
                }
                
                // Purchase Price per Share
                HStack {
                    Text("Purchase Price")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("$")
                        .foregroundColor(.secondary)
                    TextField("206.55", text: $etfInput.startPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 100)
                }
                
                // Purchase Date Picker
                DatePicker("Purchase Date", 
                          selection: $etfInput.startDate, 
                          displayedComponents: .date)
            } header: {
                Text("Purchase Details")
            }
            
            // MARK: Current Analysis Section
            Section {
                // Current Price per Share
                HStack {
                    Text("Current Price")
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("$")
                        .foregroundColor(.secondary)
                    TextField("286.77", text: $etfInput.endPriceString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 100)
                }
                
                // Analysis Date Picker
                DatePicker("Analysis Date", 
                          selection: $etfInput.endDate, 
                          displayedComponents: .date)
            } header: {
                Text("Current Analysis")
            }
            
            // MARK: Validation Warning
            // Show warning if form is incomplete but user has started entering data
            if !etfInput.name.isEmpty && !etfInput.isValid {
                Section {
                    Label {
                        Text("Please ensure all fields are filled correctly with valid numbers.")
                    } icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                    }
                    .font(.caption)
                }
            }
            
            // MARK: Quick Summary Section
            // Shows calculated values in real-time if all inputs are valid
            if etfInput.isValid,
               let shares = etfInput.shares,
               let startPrice = etfInput.startPrice,
               let endPrice = etfInput.endPrice {
                Section {
                    // Initial Investment Amount
                    HStack {
                        Text("Initial Investment")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text((shares * startPrice).formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    // Current Portfolio Value
                    HStack {
                        Text("Current Value")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text((shares * endPrice).formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    // Unrealized Gain/Loss
                    HStack {
                        Text("Unrealized Gain/Loss")
                            .foregroundColor(.secondary)
                        Spacer()
                        let gainLoss = (shares * endPrice) - (shares * startPrice)
                        Text(gainLoss.formattedAsCurrencySigned())
                            .fontWeight(.medium)
                            .foregroundColor(gainLoss >= 0 ? .green : .red)
                    }
                } header: {
                    Text("Quick Summary")
                }
            }
        }
        .navigationTitle("ETF #\(etfNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Show checkmark in toolbar when ETF is fully configured
            ToolbarItem(placement: .navigationBarTrailing) {
                if etfInput.isValid {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

// MARK: - Preview Provider
struct ETFDetailInputView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ETFDetailInputView(
                etfInput: .constant(ETFInput()),
                etfNumber: 1
            )
        }
    }
}
