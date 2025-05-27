//
// ETF_v6
// ContentView.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
// Simplified to v5 by Claude (Anthropic) on 5/26/25
// Updated to v6 with List-based UI by Claude (Anthropic) on 5/26/25
//

import SwiftUI

// MARK: - Main Content View
/// The root view using List for better scrolling and keyboard handling
struct ContentView: View {
    // MARK: - Properties
    /// @StateObject creates and owns the view model instance
    @StateObject private var viewModel = PortfolioViewModel()
    
    /// Controls whether to show analysis results
    @State private var showingResults = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            if !showingResults {
                // MARK: Input View
                PortfolioInputView(viewModel: viewModel, showingResults: $showingResults)
            } else {
                // MARK: Results View
                ResultsListView(viewModel: viewModel, showingResults: $showingResults)
            }
        }
    }
}

// MARK: - Portfolio Input View
/// List-based input view for better scrolling performance
struct PortfolioInputView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    @Binding var showingResults: Bool
    
    // MARK: - Body
    var body: some View {
        List {
            // MARK: Portfolio Setup Section
            Section {
                Stepper("Number of ETFs: \(viewModel.numberOfETFs)",
                       value: $viewModel.numberOfETFs,
                       in: 1...10)
            } header: {
                Text("Portfolio Setup")
            }
            
            // MARK: ETF Input Sections
            ForEach(viewModel.etfInputs.indices, id: \.self) { index in
                Section {
                    ETFInputFields(etfInput: $viewModel.etfInputs[index])
                } header: {
                    HStack {
                        Text("ETF #\(index + 1)")
                        Spacer()
                        if viewModel.etfInputs[index].isValid {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title3)
                        } else if !viewModel.etfInputs[index].name.isEmpty {
                            Image(systemName: "exclamationmark.circle")
                                .foregroundColor(.orange)
                                .font(.title3)
                        }
                    }
                }
            }
            
            // MARK: Action Section
            Section {
                Button(action: {
                    viewModel.analyze()
                    withAnimation {
                        showingResults = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Analyze Portfolio")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .disabled(!viewModel.allInputsValid)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.allInputsValid ? Color.accentColor : Color.gray.opacity(0.3))
                )
                .foregroundColor(.white)
            }
        }
        .navigationTitle("ETF Portfolio Analyzer")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear") {
                    viewModel.clearAll()
                }
            }
        }
    }
}

// MARK: - ETF Input Fields
/// Individual ETF input fields organized for List display
struct ETFInputFields: View {
    // MARK: - Properties
    @Binding var etfInput: ETFInput
    
    /// Formatters for number inputs
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        Group {
            // ETF Name
            HStack {
                Text("Name")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("e.g., VTI", text: $etfInput.name)
                    .textFieldStyle(.automatic)
            }
            
            // Expense Ratio
            HStack {
                Text("Expense %")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("0.03", value: $etfInput.expenseRatioPercent, formatter: decimalFormatter)
                    .textFieldStyle(.automatic)
                    .keyboardType(.decimalPad)
            }
            
            // Annual Yield
            HStack {
                Text("Yield %")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("1.5", value: $etfInput.annualYieldPercent, formatter: decimalFormatter)
                    .textFieldStyle(.automatic)
                    .keyboardType(.decimalPad)
            }
            
            // Shares
            HStack {
                Text("Shares")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("100", value: $etfInput.shares, formatter: decimalFormatter)
                    .textFieldStyle(.automatic)
                    .keyboardType(.decimalPad)
            }
            
            // Purchase Price
            HStack {
                Text("Buy Price $")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("150.00", value: $etfInput.startPrice, formatter: currencyFormatter)
                    .textFieldStyle(.automatic)
                    .keyboardType(.decimalPad)
            }
            
            // Purchase Date
            DatePicker("Purchase Date",
                      selection: $etfInput.startDate,
                      displayedComponents: .date)
                .foregroundColor(.secondary)
            
            // Current Price
            HStack {
                Text("Current $")
                    .foregroundColor(.secondary)
                    .frame(width: 100, alignment: .leading)
                TextField("175.00", value: $etfInput.endPrice, formatter: currencyFormatter)
                    .textFieldStyle(.automatic)
                    .keyboardType(.decimalPad)
            }
            
            // Analysis Date
            DatePicker("Analysis Date",
                      selection: $etfInput.endDate,
                      displayedComponents: .date)
                .foregroundColor(.secondary)
            
            // Quick Summary if valid
            if etfInput.isValid {
                VStack(alignment: .leading, spacing: 4) {
                    Divider()
                    HStack {
                        Text("Initial:")
                            .foregroundColor(.secondary)
                        Text((etfInput.shares * etfInput.startPrice).formattedAsCurrency())
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        let gain = (etfInput.shares * etfInput.endPrice) - (etfInput.shares * etfInput.startPrice)
                        Text(gain >= 0 ? "Gain:" : "Loss:")
                            .foregroundColor(.secondary)
                        Text(abs(gain).formattedAsCurrency())
                            .fontWeight(.medium)
                            .foregroundColor(gain >= 0 ? .green : .red)
                    }
                    .font(.footnote)
                }
            }
        }
    }
}

// MARK: - Results List View
/// List-based results view
struct ResultsListView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    @Binding var showingResults: Bool
    @State private var expandedETFs: Set<UUID> = []
    
    // MARK: - Body
    var body: some View {
        List {
            // MARK: Portfolio Summary Section
            if let summary = viewModel.portfolioSummary {
                Section("Portfolio Summary") {
                    SummaryMetricRow(label: "Total Invested",
                                   value: summary.initialInvestment.formattedAsCurrency(),
                                   icon: "banknote")
                    
                    SummaryMetricRow(label: "Current Value",
                                   value: summary.currentValueCapitalOnly.formattedAsCurrency(),
                                   icon: "chart.line.uptrend.xyaxis")
                    
                    SummaryMetricRow(label: "Net Return",
                                   value: summary.netReturnDollars.formattedAsCurrencySigned(),
                                   icon: "arrow.up.right",
                                   valueColor: summary.netReturnDollars >= 0 ? .green : .red)
                    
                    SummaryMetricRow(label: "Annual Return",
                                   value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct),
                                   icon: "percent")
                }
                
                // Allocation Section
                Section("Current Allocation") {
                    ForEach(summary.allocations) { allocation in
                        HStack {
                            Text(allocation.name)
                            Spacer()
                            Text(String(format: "%.1f%%", allocation.percentage))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            // MARK: Individual ETF Results
            Section {
                ForEach(viewModel.individualResults) { result in
                    ETFResultRow(result: result,
                               isExpanded: expandedETFs.contains(result.id),
                               onToggle: {
                                   withAnimation {
                                       if expandedETFs.contains(result.id) {
                                           expandedETFs.remove(result.id)
                                       } else {
                                           expandedETFs.insert(result.id)
                                       }
                                   }
                               })
                }
            } header: {
                HStack {
                    Text("Individual ETF Performance")
                    Spacer()
                    Button(expandedETFs.isEmpty ? "Expand All" : "Collapse All") {
                        withAnimation {
                            if expandedETFs.isEmpty {
                                expandedETFs = Set(viewModel.individualResults.map { $0.id })
                            } else {
                                expandedETFs.removeAll()
                            }
                        }
                    }
                    .font(.caption)
                }
            }
            
            // MARK: Actions
            Section {
                ShareLink(item: generateReport()) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share Report")
                    }
                }
                
                Button(action: {
                    withAnimation {
                        showingResults = false
                    }
                }) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Modify Inputs")
                    }
                }
            }
        }
        .navigationTitle("Analysis Results")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Helper Methods
    private func generateReport() -> String {
        var report = "ETF Portfolio Analysis Report\n"
        report += "Generated: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        
        if let summary = viewModel.portfolioSummary {
            report += "PORTFOLIO SUMMARY\n"
            report += String(repeating: "=", count: 30) + "\n"
            report += "Total Investment: \(summary.initialInvestment.formattedAsCurrency())\n"
            report += "Current Value: \(summary.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Net Return: \(summary.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annual Return: \(String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))\n\n"
        }
        
        report += "INDIVIDUAL ETF RESULTS\n"
        report += String(repeating: "=", count: 30) + "\n"
        
        for result in viewModel.individualResults {
            report += "\n\(result.name)\n"
            report += "Investment: \(result.initialInvestment.formattedAsCurrency())\n"
            report += "Current: \(result.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Net Return: \(result.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annual Return: \(String(format: "%.2f%%", result.annualizedTotalReturnPct))\n"
        }
        
        return report
    }
}

// MARK: - Summary Metric Row
struct SummaryMetricRow: View {
    let label: String
    let value: String
    let icon: String
    var valueColor: Color = .primary
    
    var body: some View {
        HStack {
            Label(label, systemImage: icon)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
                .foregroundColor(valueColor)
        }
    }
}

// MARK: - ETF Result Row
struct ETFResultRow: View {
    let result: ETFAnalysisResult
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header button
            Button(action: onToggle) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(result.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("\(result.initialInvestment.formattedAsCurrency()) → \(result.currentValueCapitalOnly.formattedAsCurrency())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(result.netReturnDollars.formattedAsCurrencySigned())
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(result.netReturnDollars >= 0 ? .green : .red)
                        Text("\(String(format: "%.1f%%", result.annualizedTotalReturnPct)) annual")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expandable details
            if isExpanded {
                VStack(alignment: .leading, spacing: 6) {
                    Divider()
                    
                    DetailRow(label: "Days Held", value: "\(result.daysHeld)")
                    DetailRow(label: "Capital Gain/Loss", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
                    DetailRow(label: "Yield Income", value: result.totalYieldIncomeDollars.formattedAsCurrency())
                    DetailRow(label: "Gross Return", value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                    DetailRow(label: "Expense Cost", value: "-\(result.totalExpenseDollars.formattedAsCurrency())")
                    
                    Divider()
                    
                    DetailRow(label: "Net Return",
                            value: result.netReturnDollars.formattedAsCurrencySigned())
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
        }
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
