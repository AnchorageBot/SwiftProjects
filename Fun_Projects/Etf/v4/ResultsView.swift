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

// MARK: - Main Results View
/// Container view that displays analysis results in a tabbed interface
/// Separates individual ETF results from portfolio summary
struct ResultsView: View {
    // MARK: - Properties
    /// Reference to the view model containing analysis results
    @ObservedObject var viewModel: PortfolioViewModel
    
    /// Tracks which tab is currently selected
    @State private var selectedTab = 0
    
    // MARK: - Body
    var body: some View {
        // TabView provides tab-based navigation for results
        TabView(selection: $selectedTab) {
            // MARK: Individual ETF Results Tab
            IndividualResultsView(results: viewModel.individualResults)
                .tabItem {
                    Label("Individual ETFs", systemImage: "chart.bar.fill")
                }
                .tag(0)
            
            // MARK: Portfolio Summary Tab
            // Only show if summary exists
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
            // Share button to export results
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareLink(item: generateReport()) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    /// Generates a text report of all analysis results
    /// Used for sharing/exporting functionality
    private func generateReport() -> String {
        var report = "ETF Portfolio Analysis Report\n"
        report += "Generated: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        
        // Individual ETF Results Section
        report += "INDIVIDUAL ETF RESULTS\n"
        report += String(repeating: "=", count: 50) + "\n\n"
        
        // Add each ETF's key metrics
        for result in viewModel.individualResults {
            report += "\(result.name)\n"
            report += "Initial Investment: \(result.initialInvestment.formattedAsCurrency())\n"
            report += "Current Value: \(result.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Net Return: \(result.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annualized Return: \(String(format: "%.2f%%", result.annualizedTotalReturnPct))\n\n"
        }
        
        // Portfolio Summary Section
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

// MARK: - Individual Results List View
/// Displays a list of all ETF results with summary information
struct IndividualResultsView: View {
    // MARK: - Properties
    let results: [ETFAnalysisResult]
    
    // MARK: - Body
    var body: some View {
        List {
            // Create a row for each ETF result
            ForEach(results) { result in
                // Navigation to detailed view for each ETF
                NavigationLink(destination: ETFResultDetailView(result: result)) {
                    VStack(alignment: .leading, spacing: 8) {
                        // ETF Name
                        Text(result.name)
                            .font(.headline)
                        
                        // Summary metrics in columns
                        HStack {
                            // Initial Investment Column
                            VStack(alignment: .leading) {
                                Text("Initial")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(result.initialInvestment.formattedAsCurrency())
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            // Current Value Column
                            VStack(alignment: .trailing) {
                                Text("Current")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(result.currentValueCapitalOnly.formattedAsCurrency())
                                    .font(.subheadline)
                            }
                            
                            Spacer()
                            
                            // Net Return Column
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

// MARK: - ETF Result Detail View
/// Detailed breakdown of a single ETF's analysis results
struct ETFResultDetailView: View {
    // MARK: - Properties
    let result: ETFAnalysisResult
    
    // MARK: - Body
    var body: some View {
        List {
            // MARK: Time Period Section
            Section {
                ResultDetailRow(label: "Days Held", value: "\(result.daysHeld)")
                ResultDetailRow(label: "Years Held", value: String(format: "%.2f", Double(result.daysHeld) / 365.0))
            } header: {
                Text("Time Period")
            }
            
            // MARK: Capital Section
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
            
            // MARK: Yield Section
            Section {
                ResultDetailRow(label: "Annual Yield Rate", 
                              value: String(format: "%.2f%%", result.annualYieldPercentInput))
                ResultDetailRow(label: "Total Yield Income", 
                              value: result.totalYieldIncomeDollars.formattedAsCurrency())
            } header: {
                Text("Yield")
            }
            
            // MARK: Returns Section
            Section {
                ResultDetailRow(label: "Total Gross Return", 
                              value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                ResultDetailRow(label: "Annualized Total Return", 
                              value: String(format: "%.2f%%", result.annualizedTotalReturnPct))
            } header: {
                Text("Returns")
            }
            
            // MARK: Final Results Section
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

// MARK: - Portfolio Summary Detail View
/// Displays the combined portfolio analysis results
struct PortfolioSummaryDetailView: View {
    // MARK: - Properties
    let summary: PortfolioSummaryResult
    
    // MARK: - Body
    var body: some View {
        List {
            // MARK: Portfolio Overview Section
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
            
            // MARK: Allocation Section
            Section {
                // Display each ETF's percentage of portfolio
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
            
            // MARK: Performance Section
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
            
            // MARK: Final Results Section
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

// MARK: - Result Detail Row Component
/// Reusable component for displaying a label-value pair in results
struct ResultDetailRow: View {
    // MARK: - Properties
    let label: String
    let value: String
    var isHighlighted: Bool = false
    var valueColor: Color? = nil
    
    // MARK: - Body
    var body: some View {
        HStack {
            // Label on the left
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            // Value on the right
            Text(value)
                .fontWeight(isHighlighted ? .bold : .regular)
                .foregroundColor(valueColor)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 2)
    }
}

// MARK: - Preview Provider
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
