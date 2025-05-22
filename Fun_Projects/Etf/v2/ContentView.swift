//
// ETF_v2
// ContentView.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PortfolioViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    PaddedSection(title: "Portfolio Setup") {
                        Stepper("Number of ETFs: \(viewModel.numberOfETFs)", value: $viewModel.numberOfETFs, in: 1...10)
                            .onChange(of: viewModel.numberOfETFs) { // Optional: Clear results if number of ETFs changes
                                viewModel.clearResults()
                            }
                    }

                    // Loop to create ETFInputView for each ETF data model instance
                    // The $etfInputBinding provides a direct two-way connection to the data
                    ForEach($viewModel.etfInputs) { $etfInputBinding in
                        // Find the index of the current ETF input to display its number
                        let index = viewModel.etfInputs.firstIndex(where: { $0.id == etfInputBinding.id }) ?? 0
                        PaddedSection(title: "ETF #\(index + 1) Details") {
                            // ETFInputView is now defined in its own file
                            ETFInputView(etfInput: $etfInputBinding)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        Button("Analyze Portfolio") {
                            viewModel.analyze()
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .disabled(!viewModel.allInputsValid) // Disable if not all inputs are valid
                        Spacer()
                    }


                    if !viewModel.individualResults.isEmpty {
                        PaddedSection(title: "Individual ETF Results") {
                            ForEach(viewModel.individualResults) { result in
                                ETFResultView(result: result)
                                if result.id != viewModel.individualResults.last?.id { // Add divider except for the last item
                                    Divider()
                                }
                            }
                        }
                    }

                    if let summary = viewModel.portfolioSummary, !viewModel.individualResults.isEmpty {
                         PaddedSection(title: "Combined Portfolio Summary") {
                            PortfolioSummaryView(summary: summary)
                        }
                    }
                }
                .padding() // Overall padding for the VStack content
            }
            .navigationTitle("ETF Portfolio Analyzer")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear Results") {
                        viewModel.clearResults()
                    }
                }
            }
        }
        // Apply to the whole NavigationView to ensure keyboard dismissal behavior if needed on wider screens
        // .onTapGesture {
        //     self.hideKeyboard()
        // }
    }
    
    // Optional: Helper to dismiss keyboard - not always necessary with ScrollView but can be useful
    // private func hideKeyboard() {
    //     UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    // }
}

// Helper view for consistent section styling
struct PaddedSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content // Allows multiple views to be passed as content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            content
        }
        .padding() // Padding inside the section
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.secondarySystemBackground))) // Background for the section
        .padding(.bottom, 5) // Spacing below the section
    }
}

// Helper view for displaying a labeled result row
struct ResultRow: View {
    let label: String
    let value: String
    var isHighlighted: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary) // Make label slightly less prominent
            Spacer()
            Text(value)
                .fontWeight(isHighlighted ? .bold : .regular)
                .multilineTextAlignment(.trailing) // Ensure long values align correctly
        }
        .padding(.vertical, 3) // Slightly more vertical padding for readability
    }
}

// View to display results for a single ETF
struct ETFResultView: View {
    let result: ETFAnalysisResult

    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // Consistent spacing
            Text(result.name)
                .font(.title3.weight(.medium)) // Make ETF name stand out
                .padding(.bottom, 4)
            
            ResultRow(label: "Days Held:", value: "\(result.daysHeld)")
            ResultRow(label: "Initial Investment:", value: result.initialInvestment.formattedAsCurrency())
            ResultRow(label: "Current Value (Capital):", value: result.currentValueCapitalOnly.formattedAsCurrency())
            ResultRow(label: "Capital Appreciation:", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
            ResultRow(label: "Annual Yield (Input):", value: String(format: "%.2f%%", result.annualYieldPercentInput))
            ResultRow(label: "Est. Yield Income:", value: result.totalYieldIncomeDollars.formattedAsCurrency())
            ResultRow(label: "Total Gross Return:", value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
            ResultRow(label: "Annualized Total Return:", value: String(format: "%.2f%%", result.annualizedTotalReturnPct))
            ResultRow(label: "Est. Expense Cost:", value: result.totalExpenseDollars.formattedAsCurrency())
            ResultRow(label: "Net Return:", value: result.netReturnDollars.formattedAsCurrencySigned(), isHighlighted: true)
        }
        .padding(.vertical) // Padding around each ETF result block
    }
}

// View to display the combined portfolio summary
struct PortfolioSummaryView: View {
    let summary: PortfolioSummaryResult

    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // Consistent spacing
            ResultRow(label: "Total Initial Investment:", value: summary.initialInvestment.formattedAsCurrency())
            ResultRow(label: "Total Current Value (Capital):", value: summary.currentValueCapitalOnly.formattedAsCurrency())
            
            Text("Portfolio Allocation:")
                .font(.headline.italic())
                .padding(.vertical, 5)
            
            if summary.allocations.isEmpty {
                Text("  N/A (Calculation pending or zero value)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                ForEach(summary.allocations) { alloc in
                    ResultRow(label: "  - \(alloc.name):", value: String(format: "%.1f%%", alloc.percentage))
                }
            }

            ResultRow(label: "Total Capital Appreciation:", value: summary.capitalAppreciationDollars.formattedAsCurrencySigned()).padding(.top, 5)
            ResultRow(label: "Total Est. Yield Income:", value: summary.totalYieldIncomeDollars.formattedAsCurrency())
            ResultRow(label: "Total Gross Return:", value: summary.totalReturnDollarsGross.formattedAsCurrencySigned())
            ResultRow(label: "Weighted Annualized Return:", value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))
            ResultRow(label: "Total Est. Expense Cost:", value: summary.totalExpenseDollars.formattedAsCurrency())
            ResultRow(label: "Total Net Return:", value: summary.netReturnDollars.formattedAsCurrencySigned(), isHighlighted: true)
        }
        .padding(.vertical) // Padding around the portfolio summary block
    }
}

// Helper extension for formatting Doubles as currency and signed currency
extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "$%.2f", self)
    }

    func formattedAsCurrencySigned() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.positivePrefix = formatter.plusSign // Show plus sign for positive numbers
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%@%.2f", self >= 0 ? "+" : "", self)
    }
}


// Optional: For Xcode Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light) // Preview in light mode
        ContentView()
            .preferredColorScheme(.dark)  // Preview in dark mode
    }
}
