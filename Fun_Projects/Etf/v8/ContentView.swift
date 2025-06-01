//
// ETF_v8
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
// Updated to v8 with fixed results display by Claude (Anthropic) on 5/31/25
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
/// Displays analysis results in a scrollable view
/// FIXED in v8: Changed from List to ScrollView to prevent content cutoff
struct ResultsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    @Binding var showingResults: Bool
    @State private var expandedETFs: Set<UUID> = []
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // MARK: Portfolio Summary
                if let summary = viewModel.portfolioSummary {
                    VStack(alignment: .leading, spacing: 16) {
                        // Summary Header
                        Text("PORTFOLIO SUMMARY")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        // Summary Metrics
                        VStack(spacing: 12) {
                            MetricRow(label: "Total Invested",
                                     value: summary.initialInvestment.formattedAsCurrency(),
                                     icon: "banknote")
                            
                            Divider().padding(.horizontal)
                            
                            MetricRow(label: "Current Value",
                                     value: summary.currentValueCapitalOnly.formattedAsCurrency(),
                                     icon: "chart.line.uptrend.xyaxis")
                            
                            Divider().padding(.horizontal)
                            
                            MetricRow(label: "Net Return",
                                     value: summary.netReturnDollars.formattedAsCurrencySigned(),
                                     icon: "arrow.up.right",
                                     valueColor: summary.netReturnDollars >= 0 ? .green : .red)
                            
                            Divider().padding(.horizontal)
                            
                            MetricRow(label: "Annual Return",
                                     value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct),
                                     icon: "percent")
                        }
                        .padding(.horizontal)
                        
                        // Allocation Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("CURRENT ALLOCATION")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            ForEach(summary.allocations) { allocation in
                                HStack {
                                    Text(allocation.name)
                                    Spacer()
                                    Text(String(format: "%.1f%%", allocation.percentage))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    .padding(.bottom, 20)
                }
                
                // MARK: Individual Results Header
                HStack {
                    Text("INDIVIDUAL ETF PERFORMANCE")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(expandedETFs.isEmpty ? "EXPAND ALL" : "COLLAPSE ALL") {
                        withAnimation {
                            if expandedETFs.isEmpty {
                                expandedETFs = Set(viewModel.individualResults.map { $0.id })
                            } else {
                                expandedETFs.removeAll()
                            }
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.accentColor)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                
                // MARK: Individual ETF Results
                VStack(spacing: 16) {
                    ForEach(viewModel.individualResults) { result in
                        ETFResultCard(
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
                }
                .padding(.horizontal)
                
                // MARK: Action Buttons
                VStack(spacing: 12) {
                    ShareLink(item: generateReport()) {
                        Label("Share Report", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.opacity(0.1))
                            .foregroundColor(.accentColor)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        withAnimation {
                            showingResults = false
                        }
                    }) {
                        Label("Modify Inputs", systemImage: "pencil")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .foregroundColor(.primary)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .padding(.bottom, 20)
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

// MARK: - ETF Result Card
/// Individual ETF result with expandable details
/// Redesigned for better space efficiency
struct ETFResultCard: View {
    let result: ETFAnalysisResult
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: Header (Always Visible)
            Button(action: onToggle) {
                VStack(spacing: 8) {
                    HStack {
                        Text(result.name)
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(result.netReturnDollars.formattedAsCurrencySigned())
                            .font(.headline)
                            .foregroundColor(result.netReturnDollars >= 0 ? .green : .red)
                    }
                    
                    HStack {
                        Text("\(result.initialInvestment.formattedAsCurrency()) → \(result.currentValueCapitalOnly.formattedAsCurrency())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Spacer()
                        
                        Text("\(String(format: "%.1f%%", result.annualizedTotalReturnPct)) annual")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            
            // MARK: Expandable Details
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    DetailRow(label: "Days Held", value: "\(result.daysHeld)")
                    DetailRow(label: "Capital Gain/Loss", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
                    DetailRow(label: "Yield Income", value: result.totalYieldIncomeDollars.formattedAsCurrency())
                    DetailRow(label: "Gross Return", value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                    DetailRow(label: "Expense Cost", value: "-\(result.totalExpenseDollars.formattedAsCurrency())")
                    
                    Divider().padding(.vertical, 4)
                    
                    DetailRow(label: "Net Return", value: result.netReturnDollars.formattedAsCurrencySigned())
                        .fontWeight(.semibold)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.top, -8) // Overlap with header slightly
            }
        }
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

/// Detail row for expandable sections
struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
