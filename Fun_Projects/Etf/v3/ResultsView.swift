//
// ETF_v3
// ResultsView.swift
//
// Created on 5/23/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Individual ETF Results Tab
            IndividualResultsView(results: viewModel.individualResults)
                .tabItem {
                    Label("Individual ETFs", systemImage: "chart.bar.fill")
                }
                .tag(0)
            
            // Portfolio Summary Tab
            if let summary = viewModel.portfolioSummary {
                PortfolioSummaryDetailView(summary: summary)
                    .tabItem {
                        Label("Portfolio Summary", systemImage: "chart.pie.fill")
                    }
                    .tag(1)
            }
        }
        .navigationTitle("Analysis Results")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: generateReport()) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    private func generateReport() -> String {
        var report = "ETF Portfolio Analysis Report\n"
        report += "Generated: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        
        // Individual ETF Results
        report += "INDIVIDUAL ETF RESULTS\n"
        report += String(repeating: "=", count: 50) + "\n\n"
        
        for result in viewModel.individualResults {
            report += "\(result.name)\n"
            report += "Initial Investment: \(result.initialInvestment.formattedAsCurrency())\n"
            report += "Current Value: \(result.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Net Return: \(result.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annualized Return: \(String(format: "%.2f%%", result.annualizedTotalReturnPct))\n\n"
        }
        
        // Portfolio Summary
        if let summary = viewModel.portfolioSummary {
            report += "PORTFOLIO SUMMARY\n"
            report += String(repeating: "=", count: 50) + "\n\n"
            report += "Total Investment: \(summary.initialInvestment.formattedAsCurrency())\n"
            report += "Total Current Value: \(summary.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Total Net Return: \(summary.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Weighted Annual Return: \(String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))\n"
        }
        
        return report
    }
}

// Individual ETF Results List View
struct IndividualResultsView: View {
    let results: [ETFAnalysisResult]
    
    var body: some View {
        List {
            ForEach(results) { result in
                NavigationLink(destination: ETFResultDetailView(result: result)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(result.name)
                            .font(.headline)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Initial")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(result.initialInvestment.formattedAsCurrency())
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Current")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(result.currentValueCapitalOnly.formattedAsCurrency())
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Net Return")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(result.netReturnDollars.formattedAsCurrencySigned())
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(result.netReturnDollars >= 0 ? .green : .red)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

// Detailed view for individual ETF result
struct ETFResultDetailView: View {
    let result: ETFAnalysisResult
    
    var body: some View {
        List {
            Section {
                ResultDetailRow(label: "Days Held", value: "\(result.daysHeld)")
                ResultDetailRow(label: "Years Held", value: String(format: "%.2f", Double(result.daysHeld) / 365.0))
            } header: {
                Text("Time Period")
            }
            
            Section {
                ResultDetailRow(label: "Initial Investment",
                              value: result.initialInvestment.formattedAsCurrency())
                ResultDetailRow(label: "Current Value (Capital)",
                              value: result.currentValueCapitalOnly.formattedAsCurrency())
                ResultDetailRow(label: "Capital Appreciation",
                              value: result.capitalAppreciationDollars.formattedAsCurrencySigned(),
                              valueColor: result.capitalAppreciationDollars >= 0 ? .green : .red)
            } header: {
                Text("Capital")
            }
            
            Section {
                ResultDetailRow(label: "Annual Yield Rate",
                              value: String(format: "%.2f%%", result.annualYieldPercentInput))
                ResultDetailRow(label: "Total Yield Income",
                              value: result.totalYieldIncomeDollars.formattedAsCurrency())
            } header: {
                Text("Yield")
            }
            
            Section {
                ResultDetailRow(label: "Total Gross Return",
                              value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                ResultDetailRow(label: "Annualized Total Return",
                              value: String(format: "%.2f%%", result.annualizedTotalReturnPct))
            } header: {
                Text("Returns")
            }
            
            Section {
                ResultDetailRow(label: "Total Expense Cost",
                              value: result.totalExpenseDollars.formattedAsCurrency())
                ResultDetailRow(label: "Net Return",
                              value: result.netReturnDollars.formattedAsCurrencySigned(),
                              isHighlighted: true,
                              valueColor: result.netReturnDollars >= 0 ? .green : .red)
            } header: {
                Text("Final Results")
            }
        }
        .navigationTitle(result.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

// Portfolio Summary Detail View
struct PortfolioSummaryDetailView: View {
    let summary: PortfolioSummaryResult
    
    var body: some View {
        List {
            Section {
                ResultDetailRow(label: "Total Initial Investment",
                              value: summary.initialInvestment.formattedAsCurrency())
                ResultDetailRow(label: "Total Current Value",
                              value: summary.currentValueCapitalOnly.formattedAsCurrency())
                ResultDetailRow(label: "Total Capital Appreciation",
                              value: summary.capitalAppreciationDollars.formattedAsCurrencySigned(),
                              valueColor: summary.capitalAppreciationDollars >= 0 ? .green : .red)
            } header: {
                Text("Portfolio Overview")
            }
            
            Section {
                ForEach(summary.allocations) { allocation in
                    HStack {
                        Text(allocation.name)
                        Spacer()
                        Text(String(format: "%.1f%%", allocation.percentage))
                            .foregroundColor(.secondary)
                    }
                }
            } header: {
                Text("Current Allocation")
            }
            
            Section {
                ResultDetailRow(label: "Total Yield Income",
                              value: summary.totalYieldIncomeDollars.formattedAsCurrency())
                ResultDetailRow(label: "Total Gross Return",
                              value: summary.totalReturnDollarsGross.formattedAsCurrencySigned())
                ResultDetailRow(label: "Weighted Annual Return",
                              value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))
            } header: {
                Text("Performance")
            }
            
            Section {
                ResultDetailRow(label: "Total Expense Cost",
                              value: summary.totalExpenseDollars.formattedAsCurrency())
                ResultDetailRow(label: "Total Net Return",
                              value: summary.netReturnDollars.formattedAsCurrencySigned(),
                              isHighlighted: true,
                              valueColor: summary.netReturnDollars >= 0 ? .green : .red)
            } header: {
                Text("Final Results")
            }
        }
    }
}

// Helper view for result rows
struct ResultDetailRow: View {
    let label: String
    let value: String
    var isHighlighted: Bool = false
    var valueColor: Color? = nil
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(isHighlighted ? .bold : .regular)
                .foregroundColor(valueColor)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 2)
    }
}

// Preview
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ResultsView(viewModel: {
                let vm = PortfolioViewModel()
                // Add sample data for preview
                return vm
            }())
        }
    }
}
