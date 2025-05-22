//
// ETF_v1
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
                    }

                    ForEach($viewModel.etfInputs) { $etfInputBinding in // Use the binding
                        let index = viewModel.etfInputs.firstIndex(where: { $0.id == etfInputBinding.id }) ?? 0
                        PaddedSection(title: "ETF #\(index + 1) Details") {
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
                        .disabled(!viewModel.allInputsValid)
                        Spacer()
                    }


                    if !viewModel.individualResults.isEmpty {
                        PaddedSection(title: "Individual ETF Results") {
                            ForEach(viewModel.individualResults) { result in
                                ETFResultView(result: result)
                                Divider()
                            }
                        }
                    }

                    if let summary = viewModel.portfolioSummary, !viewModel.individualResults.isEmpty {
                         PaddedSection(title: "Combined Portfolio Summary") {
                            PortfolioSummaryView(summary: summary)
                        }
                    }
                }
                .padding()
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
    }
}

struct PaddedSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            content
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.secondarySystemBackground)))
        .padding(.bottom, 5)
    }
}


struct ETFInputView: View {
    @Binding var etfInput: ETFInput // Use binding to allow modifications

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 4 // Adjust as needed
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            TextField("ETF Name (e.g., VTI)", text: $etfInput.name)
            HStack {
                TextField("Expense Ratio (%)", text: $etfInput.expenseRatioPercentString)
                    .keyboardType(.decimalPad)
                TextField("Annual Yield (%)", text: $etfInput.annualYieldPercentString)
                    .keyboardType(.decimalPad)
            }
            HStack {
                TextField("Shares", text: $etfInput.sharesString)
                    .keyboardType(.decimalPad)
                TextField("Start Price ($)", text: $etfInput.startPriceString)
                    .keyboardType(.decimalPad)
            }
            DatePicker("Purchase Date", selection: $etfInput.startDate, displayedComponents: .date)
            
            HStack {
                TextField("Current Price ($)", text: $etfInput.endPriceString)
                    .keyboardType(.decimalPad)
                DatePicker("Analysis Date", selection: $etfInput.endDate, displayedComponents: .date)
            }
            if !etfInput.isValid && !etfInput.name.isEmpty { // Basic validation hint
                 Text("Ensure all fields are valid and end date is not before start date.")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ResultRow: View {
    let label: String
    let value: String
    var isHighlighted: Bool = false

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .fontWeight(isHighlighted ? .bold : .regular)
        }
        .padding(.vertical, 2)
    }
}

struct ETFResultView: View {
    let result: ETFAnalysisResult

    var body: some View {
        VStack(alignment: .leading) {
            Text(result.name)
                .font(.title3).padding(.bottom, 2)
            ResultRow(label: "Days Held:", value: "\(result.daysHeld)")
            ResultRow(label: "Initial Investment:", value: String(format: "$%.2f", result.initialInvestment))
            ResultRow(label: "Current Value (Capital):", value: String(format: "$%.2f", result.currentValueCapitalOnly))
            ResultRow(label: "Capital Appreciation:", value: String(format: "$%.2f", result.capitalAppreciationDollars))
            ResultRow(label: "Annual Yield (Input):", value: String(format: "%.2f%%", result.annualYieldPercentInput))
            ResultRow(label: "Est. Yield Income:", value: String(format: "$%.2f", result.totalYieldIncomeDollars))
            ResultRow(label: "Total Gross Return:", value: String(format: "$%.2f", result.totalReturnDollarsGross))
            ResultRow(label: "Annualized Total Return:", value: String(format: "%.2f%%", result.annualizedTotalReturnPct))
            ResultRow(label: "Est. Expense Cost:", value: String(format: "$%.2f", result.totalExpenseDollars))
            ResultRow(label: "Net Return:", value: String(format: "$%.2f", result.netReturnDollars), isHighlighted: true)
        }
        .padding(.vertical)
    }
}

struct PortfolioSummaryView: View {
    let summary: PortfolioSummaryResult

    var body: some View {
        VStack(alignment: .leading) {
            ResultRow(label: "Total Initial Investment:", value: String(format: "$%.2f", summary.initialInvestment))
            ResultRow(label: "Total Current Value (Capital):", value: String(format: "$%.2f", summary.currentValueCapitalOnly))
            
            Text("Portfolio Allocation:").font(.headline.italic()).padding(.top, 5)
            ForEach(summary.allocations) { alloc in
                ResultRow(label: "  - \(alloc.name):", value: String(format: "%.1f%%", alloc.percentage))
            }

            ResultRow(label: "Total Capital Appreciation:", value: String(format: "$%.2f", summary.capitalAppreciationDollars)).padding(.top, 5)
            ResultRow(label: "Total Est. Yield Income:", value: String(format: "$%.2f", summary.totalYieldIncomeDollars))
            ResultRow(label: "Total Gross Return:", value: String(format: "$%.2f", summary.totalReturnDollarsGross))
            ResultRow(label: "Weighted Annualized Return:", value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))
            ResultRow(label: "Total Est. Expense Cost:", value: String(format: "$%.2f", summary.totalExpenseDollars))
            ResultRow(label: "Total Net Return:", value: String(format: "$%.2f", summary.netReturnDollars), isHighlighted: true)
        }
        .padding(.vertical)
    }
}


// Optional: For Xcode Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
