//
// ETF_v5
// UnifiedResultsView.swift
//
// Created on 5/26/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
// Simplified to v5 by Claude (Anthropic) on 5/26/25
//

import SwiftUI

// MARK: - Unified Results View
/// Single scrollable view displaying all analysis results
/// Eliminates tabs and multiple navigation levels for simplicity
struct UnifiedResultsView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    
    /// Controls which ETF details are expanded
    @State private var expandedETFs: Set<UUID> = []
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            // MARK: Portfolio Summary Card
            if let summary = viewModel.portfolioSummary {
                PortfolioSummaryCard(summary: summary)
            }
            
            // MARK: Individual ETF Results
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Individual ETF Performance")
                        .font(.headline)
                    
                    Spacer()
                    
                    // Expand/Collapse All button
                    Button(action: toggleAllETFs) {
                        Text(expandedETFs.isEmpty ? "Expand All" : "Collapse All")
                            .font(.caption)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding(.horizontal)
                
                // ETF result cards
                ForEach(viewModel.individualResults) { result in
                    ETFResultCard(
                        result: result,
                        isExpanded: expandedETFs.contains(result.id),
                        onToggle: { toggleETF(result.id) }
                    )
                }
            }
            
            // MARK: Share Button
            ShareLink(item: generateReport()) {
                Label("Share Report", systemImage: "square.and.arrow.up")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor.opacity(0.1))
                    .foregroundColor(.accentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Helper Methods
    /// Toggles expansion state for a specific ETF
    private func toggleETF(_ id: UUID) {
        if expandedETFs.contains(id) {
            expandedETFs.remove(id)
        } else {
            expandedETFs.insert(id)
        }
    }
    
    /// Toggles all ETFs between expanded and collapsed
    private func toggleAllETFs() {
        if expandedETFs.isEmpty {
            // Expand all
            expandedETFs = Set(viewModel.individualResults.map { $0.id })
        } else {
            // Collapse all
            expandedETFs.removeAll()
        }
    }
    
    /// Generates a text report for sharing
    private func generateReport() -> String {
        var report = "ETF Portfolio Analysis Report\n"
        report += "Generated: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        
        // Portfolio Summary
        if let summary = viewModel.portfolioSummary {
            report += "PORTFOLIO SUMMARY\n"
            report += String(repeating: "=", count: 30) + "\n"
            report += "Total Investment: \(summary.initialInvestment.formattedAsCurrency())\n"
            report += "Current Value: \(summary.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Total Net Return: \(summary.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Weighted Annual Return: \(String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))\n\n"
        }
        
        // Individual ETFs
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

// MARK: - Portfolio Summary Card
/// Displays the overall portfolio performance metrics
struct PortfolioSummaryCard: View {
    let summary: PortfolioSummaryResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Portfolio Summary")
                .font(.title2)
                .fontWeight(.bold)
            
            // Key metrics grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                MetricView(
                    label: "Total Invested",
                    value: summary.initialInvestment.formattedAsCurrency(),
                    icon: "banknote"
                )
                
                MetricView(
                    label: "Current Value",
                    value: summary.currentValueCapitalOnly.formattedAsCurrency(),
                    icon: "chart.line.uptrend.xyaxis"
                )
                
                MetricView(
                    label: "Net Return",
                    value: summary.netReturnDollars.formattedAsCurrencySigned(),
                    icon: "arrow.up.right",
                    valueColor: summary.netReturnDollars >= 0 ? .green : .red
                )
                
                MetricView(
                    label: "Annual Return",
                    value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct),
                    icon: "percent"
                )
            }
            
            // Allocation breakdown
            Divider()
            
            Text("Current Allocation")
                .font(.headline)
            
            ForEach(summary.allocations) { allocation in
                HStack {
                    Text(allocation.name)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(String(format: "%.1f%%", allocation.percentage))
                        .fontWeight(.medium)
                }
                .font(.subheadline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

// MARK: - ETF Result Card
/// Displays individual ETF performance with expandable details
struct ETFResultCard: View {
    let result: ETFAnalysisResult
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // MARK: Header (Always Visible)
            Button(action: onToggle) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(result.name)
                            .font(.headline)
                        
                        HStack {
                            Text(result.initialInvestment.formattedAsCurrency())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Image(systemName: "arrow.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Text(result.currentValueCapitalOnly.formattedAsCurrency())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(result.netReturnDollars.formattedAsCurrencySigned())
                            .font(.headline)
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
            
            // MARK: Expandable Details
            if isExpanded {
                Divider()
                
                VStack(spacing: 8) {
                    DetailRow(label: "Days Held", value: "\(result.daysHeld)")
                    DetailRow(label: "Capital Gain/Loss", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
                    DetailRow(label: "Yield Income", value: result.totalYieldIncomeDollars.formattedAsCurrency())
                    DetailRow(label: "Gross Return", value: result.totalReturnDollarsGross.formattedAsCurrencySigned())
                    DetailRow(label: "Expense Cost", value: "-\(result.totalExpenseDollars.formattedAsCurrency())")
                    
                    Divider()
                    
                    DetailRow(
                        label: "Net Return",
                        value: result.netReturnDollars.formattedAsCurrencySigned(),
                        isHighlighted: true
                    )
                }
                .font(.subheadline)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// MARK: - Helper Views
/// Displays a metric with an icon
struct MetricView: View {
    let label: String
    let value: String
    let icon: String
    var valueColor: Color = .primary
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.headline)
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Displays a label-value pair for detail rows
struct DetailRow: View {
    let label: String
    let value: String
    var isHighlighted: Bool = false
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(isHighlighted ? .semibold : .regular)
        }
    }
}
