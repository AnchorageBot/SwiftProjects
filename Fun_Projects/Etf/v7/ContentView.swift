//
// ETF_v7
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
// Updated to v7 with separate screens per ETF by Claude (Anthropic) on 5/26/25
//

import SwiftUI

// MARK: - Main Content View
/// Root view with navigation to individual ETF screens
struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var showingResults = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            if !showingResults {
                // Portfolio setup and ETF list
                PortfolioListView(viewModel: viewModel, showingResults: $showingResults)
            } else {
                // Results view
                ResultsView(viewModel: viewModel, showingResults: $showingResults)
            }
        }
    }
}

// MARK: - Portfolio List View
/// Main screen showing list of ETFs with navigation to each
struct PortfolioListView: View {
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
            } footer: {
                Text("Add up to 10 ETFs to your portfolio")
            }
            
            // MARK: ETF List Section
            Section {
                ForEach(viewModel.etfInputs.indices, id: \.self) { index in
                    NavigationLink(destination: ETFDetailScreen(
                        etfInput: $viewModel.etfInputs[index],
                        etfNumber: index + 1
                    )) {
                        ETFListRow(etfInput: viewModel.etfInputs[index], etfNumber: index + 1)
                    }
                }
            } header: {
                Text("ETFs")
            } footer: {
                Text("Tap each ETF to enter its details")
            }
            
            // MARK: Analyze Button Section
            Section {
                Button(action: {
                    viewModel.analyze()
                    withAnimation {
                        showingResults = true
                    }
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Analyze Portfolio")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .disabled(!viewModel.allInputsValid)
                .foregroundColor(viewModel.allInputsValid ? .white : .gray)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(viewModel.allInputsValid ? Color.accentColor : Color.gray.opacity(0.3))
                )
            } footer: {
                if !viewModel.allInputsValid {
                    Text("Complete all ETF details to enable analysis")
                        .foregroundColor(.orange)
                }
            }
        }
        .navigationTitle("ETF Portfolio")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear All") {
                    viewModel.clearAll()
                }
            }
        }
    }
}

// MARK: - ETF List Row
/// Row displaying ETF summary in the main list
struct ETFListRow: View {
    let etfInput: ETFInput
    let etfNumber: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("ETF #\(etfNumber)")
                    .font(.headline)
                
                if !etfInput.name.isEmpty {
                    Text(etfInput.name)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    if etfInput.isValid {
                        Text("Ready • \((etfInput.shares * etfInput.startPrice).formattedAsCurrency())")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                } else {
                    Text("Tap to configure")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Status indicator
            if etfInput.isValid {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title2)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - ETF Detail Screen
/// Full screen for entering individual ETF data
struct ETFDetailScreen: View {
    // MARK: - Properties
    @Binding var etfInput: ETFInput
    let etfNumber: Int
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, expense, yield, shares, startPrice, endPrice
    }
    
    // Number formatters
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
        Form {
            // MARK: Basic Information Section
            Section("Basic Information") {
                TextField("ETF Name (e.g., VTI)", text: $etfInput.name)
                    .focused($focusedField, equals: .name)
            }
            
            // MARK: Performance Metrics Section
            Section("Performance Metrics") {
                HStack {
                    Text("Expense Ratio")
                    Spacer()
                    TextField("0.03", value: $etfInput.expenseRatioPercent, formatter: decimalFormatter)
                        .focused($focusedField, equals: .expense)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                    Text("%")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Annual Yield")
                    Spacer()
                    TextField("1.5", value: $etfInput.annualYieldPercent, formatter: decimalFormatter)
                        .focused($focusedField, equals: .yield)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 80)
                    Text("%")
                        .foregroundColor(.secondary)
                }
            }
            
            // MARK: Investment Details Section
            Section("Investment Details") {
                HStack {
                    Text("Number of Shares")
                    Spacer()
                    TextField("100", value: $etfInput.shares, formatter: decimalFormatter)
                        .focused($focusedField, equals: .shares)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                
                HStack {
                    Text("Purchase Price")
                    Spacer()
                    Text("$")
                        .foregroundColor(.secondary)
                    TextField("150.00", value: $etfInput.startPrice, formatter: currencyFormatter)
                        .focused($focusedField, equals: .startPrice)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                
                DatePicker("Purchase Date",
                          selection: $etfInput.startDate,
                          displayedComponents: .date)
            }
            
            // MARK: Current Analysis Section
            Section("Current Analysis") {
                HStack {
                    Text("Current Price")
                    Spacer()
                    Text("$")
                        .foregroundColor(.secondary)
                    TextField("175.00", value: $etfInput.endPrice, formatter: currencyFormatter)
                        .focused($focusedField, equals: .endPrice)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .frame(width: 100)
                }
                
                DatePicker("Analysis Date",
                          selection: $etfInput.endDate,
                          displayedComponents: .date)
            }
            
            // MARK: Summary Section
            if etfInput.isValid {
                Section("Summary") {
                    let initialValue = etfInput.shares * etfInput.startPrice
                    let currentValue = etfInput.shares * etfInput.endPrice
                    let gain = currentValue - initialValue
                    let gainPercent = (gain / initialValue) * 100
                    
                    HStack {
                        Text("Initial Investment")
                        Spacer()
                        Text(initialValue.formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("Current Value")
                        Spacer()
                        Text(currentValue.formattedAsCurrency())
                            .fontWeight(.medium)
                    }
                    
                    HStack {
                        Text("Unrealized Gain/Loss")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(gain.formattedAsCurrencySigned())
                                .fontWeight(.medium)
                                .foregroundColor(gain >= 0 ? .green : .red)
                            Text(String(format: "%.2f%%", gainPercent))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
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
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
    }
}

// MARK: - Results View
/// Displays analysis results with expandable sections
struct ResultsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    @Binding var showingResults: Bool
    @State private var expandedETFs: Set<UUID> = []
    
    // MARK: - Body
    var body: some View {
        List {
            // MARK: Portfolio Summary
            if let summary = viewModel.portfolioSummary {
                Section("Portfolio Summary") {
                    MetricRow(label: "Total Invested",
                             value: summary.initialInvestment.formattedAsCurrency(),
                             icon: "banknote")
                    
                    MetricRow(label: "Current Value",
                             value: summary.currentValueCapitalOnly.formattedAsCurrency(),
                             icon: "chart.line.uptrend.xyaxis")
                    
                    MetricRow(label: "Net Return",
                             value: summary.netReturnDollars.formattedAsCurrencySigned(),
                             icon: "arrow.up.right",
                             valueColor: summary.netReturnDollars >= 0 ? .green : .red)
                    
                    MetricRow(label: "Annual Return",
                             value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct),
                             icon: "percent")
                }
                
                // Portfolio Allocation
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
            
            // MARK: Individual Results
            Section {
                ForEach(viewModel.individualResults) { result in
                    ETFResultRow(
                        result: result,
                        isExpanded: expandedETFs.contains(result.id),
                        onToggle: {
                            withAnimation {
                                if expandedETFs.contains(result.id) {
                                    expandedETFs.remove(result.id)
                                } else {
                                    expandedETFs.insert(result.id)
                                }
                            }
                        }
                    )
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
                    Label("Share Report", systemImage: "square.and.arrow.up")
                }
                
                Button(action: {
                    withAnimation {
                        showingResults = false
                    }
                }) {
                    Label("Modify Inputs", systemImage: "pencil")
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

// MARK: - Helper Views
/// Metric row for summary display
struct MetricRow: View {
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

/// ETF result row with expandable details
struct ETFResultRow: View {
    let result: ETFAnalysisResult
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
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
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 6) {
                    Divider()
                    
                    DetailRow(label: "Days Held", value: "\(result.daysHeld)")
                    DetailRow(label: "Capital Gain/Loss", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
                    DetailRow(label: "Yield Income", value: result.totalYieldIncomeDollars.formattedAsCurrency())
                    DetailRow(label: "Gross Return", value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                    DetailRow(label: "Expense Cost", value: "-\(result.totalExpenseDollars.formattedAsCurrency())")
                    
                    Divider()
                    
                    DetailRow(label: "Net Return", value: result.netReturnDollars.formattedAsCurrencySigned())
                        .fontWeight(.semibold)
                }
                .font(.footnote)
            }
        }
    }
}

/// Detail row for expandable sections
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

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
