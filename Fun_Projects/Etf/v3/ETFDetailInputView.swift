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

struct ETFDetailInputView: View {
    @Binding var etfInput: ETFInput
    let etfNumber: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("ETF Name")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("e.g., VTI, QQQ", text: $etfInput.name)
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                Text("Basic Information")
            }
            
            Section {
                HStack {
                    Text("Expense Ratio")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("0.03", text: $etfInput.expenseRatioPercentString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 80)
                    Text("%")
                        .foregroundColor(.secondary)
                }
                
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
            
            Section {
                HStack {
                    Text("Number of Shares")
                        .foregroundColor(.secondary)
                    Spacer()
                    TextField("10", text: $etfInput.sharesString)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 100)
                }
                
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
                
                DatePicker("Purchase Date",
                          selection: $etfInput.startDate,
                          displayedComponents: .date)
            } header: {
                Text("Purchase Details")
            }
            
            Section {
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
                
                DatePicker("Analysis Date",
                          selection: $etfInput.endDate,
                          displayedComponents: .date)
            } header: {
                Text("Current Analysis")
            }
            
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
            
            // Summary section showing calculated values if valid
            if etfInput.isValid,
               let shares = etfInput.shares,
               let startPrice = etfInput.startPrice,
               let endPrice = etfInput.endPrice {
                Section {
                    HStack {
                        Text("Initial Investment")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text((shares * startPrice).formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("Current Value")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text((shares * endPrice).formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("Unrealized Gain/Loss")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(((shares * endPrice) - (shares * startPrice)).formattedAsCurrencySigned())
                            .fontWeight(.medium)
                            .foregroundColor(((shares * endPrice) - (shares * startPrice)) >= 0 ? .green : .red)
                    }
                } header: {
                    Text("Quick Summary")
                }
            }
        }
        .navigationTitle("ETF #\(etfNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if etfInput.isValid {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

// Preview
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
