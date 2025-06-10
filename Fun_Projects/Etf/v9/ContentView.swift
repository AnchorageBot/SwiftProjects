//
// ETF_v9
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
// Updated to v9 with improved results display by Gemini (Google) on 6/8/25
//

import SwiftUI

// MARK: - Root Content View
/// The main view of the app, which uses a `NavigationStack` to manage the flow
/// between the input list and the results screen.
struct ContentView: View {
    /// `@StateObject` creates and owns the single instance of `PortfolioViewModel` for the entire app.
    @StateObject private var viewModel = PortfolioViewModel()
    
    /// `@State` property to control whether the input screen or results screen is shown.
    @State private var showingResults = false
     
    var body: some View {
        NavigationStack {
            if showingResults {
                // If `showingResults` is true, display the analysis results.
                ResultsView(viewModel: viewModel, showingResults: $showingResults)
            } else {
                // Otherwise, show the main portfolio list for data entry.
                PortfolioListView(viewModel: viewModel, showingResults: $showingResults)
            }
        }
    }
}

// MARK: - Portfolio List View
/// The main input screen where the user can set the number of ETFs and navigate to each one's detail screen.
struct PortfolioListView: View {
    /// `@ObservedObject` subscribes to the `viewModel` instance created by the parent view.
    @ObservedObject var viewModel: PortfolioViewModel
    
    /// A `@Binding` to the `showingResults` state in `ContentView`, allowing this view to change it.
    @Binding var showingResults: Bool
     
    var body: some View {
        List {
            // MARK: Portfolio Setup Section
            Section(header: Text("Portfolio Setup"), footer: Text("Add up to 10 ETFs to your portfolio.")) {
                Stepper("Number of ETFs: \(viewModel.numberOfETFs)",
                        value: $viewModel.numberOfETFs,
                        in: 1...10)
            }
             
            // MARK: ETF List Section
            Section(header: Text("ETFs"), footer: Text("Tap each ETF to enter its details.")) {
                // Dynamically create a navigation link for each ETF in the view model.
                ForEach($viewModel.etfInputs) { $etfInput in
                    // Each link goes to an `ETFDetailScreen` for that specific ETF.
                    NavigationLink(destination: ETFDetailScreen(etfInput: $etfInput, etfNumber: (viewModel.etfInputs.firstIndex(where: { $0.id == etfInput.id }) ?? 0) + 1)) {
                        // The row's appearance is defined in `ETFListRow`.
                        ETFListRow(etfInput: etfInput)
                    }
                }
            }
             
            // MARK: Analyze Button Section
            Section(footer: Text(viewModel.allInputsValid ? "" : "Complete all ETF details to enable analysis.").foregroundColor(.orange)) {
                Button(action: {
                    viewModel.analyze()
                    withAnimation {
                        showingResults = true // Transition to the results view.
                    }
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "chart.line.uptrend.xyaxis")
                        Text("Analyze Portfolio").fontWeight(.semibold)
                        Spacer()
                    }
                }
                // The button is disabled until all inputs are valid.
                .disabled(!viewModel.allInputsValid)
                // Style the button to look active or inactive.
                .foregroundColor(viewModel.allInputsValid ? .white : .gray)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.allInputsValid ? Color.accentColor : Color.gray.opacity(0.3))
                )
            }
        }
        .navigationTitle("ETF Portfolio")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Clear All", action: viewModel.clearAll)
            }
        }
    }
}

// MARK: - ETF List Row
/// A reusable view for displaying a single ETF's status in the `PortfolioListView`.
struct ETFListRow: View {
    let etfInput: ETFInput
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                // Display the ETF name or a placeholder if not yet entered.
                Text(etfInput.name.isEmpty ? "Untitled ETF" : etfInput.name)
                    .font(.headline)
                
                // Show summary information if the data is valid.
                if etfInput.isValid {
                    Text("Ready • \((etfInput.shares * etfInput.startPrice).formattedAsCurrency())")
                        .font(.caption)
                        .foregroundColor(.green)
                } else {
                    Text("Tap to configure")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Spacer()
            // Display a visual indicator of the ETF's status.
            Image(systemName: etfInput.isValid ? "checkmark.circle.fill" : "pencil.circle")
                .foregroundColor(etfInput.isValid ? .green : .orange)
                .font(.title2)
        }
        .padding(.vertical, 4)
    }
}


// MARK: - ETF Detail Screen
/// A form where the user enters all the data for a single ETF.
struct ETFDetailScreen: View {
    @Binding var etfInput: ETFInput
    let etfNumber: Int
    @FocusState private var focusedField: Field?
    
    /// An enum to manage which text field is currently focused.
    enum Field {
        case name, expense, yield, shares, startPrice, endPrice
    }
    
    var body: some View {
        Form {
            // MARK: Basic Info
            Section("Basic Information") {
                TextField("ETF Name (e.g., VTI)", text: $etfInput.name)
                    .focused($focusedField, equals: .name)
            }
            
            // MARK: Performance Metrics
            Section("Performance Metrics (%)") {
                HStack {
                    Text("Expense Ratio")
                    Spacer()
                    TextField("0.03", value: $etfInput.expenseRatioPercent, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .expense)
                }
                HStack {
                    Text("Annual Yield")
                    Spacer()
                    TextField("1.5", value: $etfInput.annualYieldPercent, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .yield)
                }
            }
            
            // MARK: Investment Details
            Section("Investment Details") {
                HStack {
                    Text("Number of Shares")
                    Spacer()
                    TextField("10", value: $etfInput.shares, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .shares)
                }
                HStack {
                    Text("Purchase Price")
                    Spacer()
                    TextField("150.00", value: $etfInput.startPrice, format: .currency(code: "USD"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .startPrice)
                }
                DatePicker("Purchase Date", selection: $etfInput.startDate, in: ...Date(), displayedComponents: .date)
            }
            
            // MARK: Current Analysis
            Section("Current Analysis") {
                HStack {
                    Text("Current Price")
                    Spacer()
                    TextField("175.00", value: $etfInput.endPrice, format: .currency(code: "USD"))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .endPrice)
                }
                DatePicker("Analysis Date", selection: $etfInput.endDate, in: etfInput.startDate..., displayedComponents: .date)
            }
        }
        .navigationTitle("ETF #\(etfNumber) Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Add a "Done" button to the keyboard toolbar to dismiss it easily.
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
    }
}


// MARK: - Results View
/// **V9 REFACTOR**: Displays the analysis results. The key change is moving the action
/// buttons *outside* the `ScrollView` to ensure they are always visible.
struct ResultsView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    @Binding var showingResults: Bool
    @State private var expandedETFs: Set<UUID> = [] // Tracks which ETF cards are expanded

    var body: some View {
        VStack(spacing: 0) {
            // The `ScrollView` contains only the content that needs to scroll.
            ScrollView {
                VStack(spacing: 24) {
                    if let summary = viewModel.portfolioSummary {
                        PortfolioSummaryCard(summary: summary)
                    }
                    
                    IndividualResultsSection(
                        results: viewModel.individualResults,
                        expandedETFs: $expandedETFs
                    )
                }
                .padding()
            }
            
            // **V9 FIX**: This `VStack` is outside the ScrollView, so it remains fixed at the bottom.
            VStack(spacing: 12) {
                ShareLink(item: generateReport(), subject: Text("My ETF Portfolio Analysis")) {
                    Label("Share Report", systemImage: "square.and.arrow.up")
                        .modifier(ActionButtonStyle(color: .accentColor))
                }
                
                Button(action: {
                    withAnimation { showingResults = false }
                }) {
                    Label("Modify Inputs", systemImage: "pencil")
                        .modifier(ActionButtonStyle(color: .secondary))
                }
            }
            .padding([.horizontal, .bottom])
            .padding(.top, 8)
            .background(.thinMaterial) // Adds a background to separate from scrolled content
        }
        .navigationTitle("Analysis Results")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    withAnimation { showingResults = false }
                }
            }
        }
    }
    
    /// Generates a plain text report for sharing.
    private func generateReport() -> String {
        var report = "ETF Portfolio Analysis Report\n"
        report += "Generated: \(Date().formatted(date: .abbreviated, time: .shortened))\n\n"
        
        if let summary = viewModel.portfolioSummary {
            report += "--- PORTFOLIO SUMMARY ---\n"
            report += "Total Invested: \(summary.initialInvestment.formattedAsCurrency())\n"
            report += "Current Value: \(summary.currentValueCapitalOnly.formattedAsCurrency())\n"
            report += "Net Return: \(summary.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annual Return: \(String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))\n\n"
        }
        
        report += "--- INDIVIDUAL ETF RESULTS ---\n"
        for result in viewModel.individualResults {
            report += "\n\(result.name.uppercased())\n"
            report += "Net Return: \(result.netReturnDollars.formattedAsCurrencySigned())\n"
            report += "Annual Return: \(String(format: "%.2f%%", result.annualizedTotalReturnPct))\n"
        }
        
        return report
    }
}


// MARK: - Results View Components
/// A card displaying the overall portfolio summary.
struct PortfolioSummaryCard: View {
    let summary: PortfolioSummaryResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Portfolio Summary")
                .font(.title2).bold()
            
            MetricRow(label: "Total Invested", value: summary.initialInvestment.formattedAsCurrency())
            MetricRow(label: "Current Value", value: summary.currentValueCapitalOnly.formattedAsCurrency())
            MetricRow(label: "Net Return", value: summary.netReturnDollars.formattedAsCurrencySigned(), valueColor: summary.netReturnDollars >= 0 ? .green : .red)
            MetricRow(label: "Weighted Annual Return", value: String(format: "%.2f%%", summary.weightedAnnualizedTotalReturnPct))
            
            if !summary.allocations.isEmpty {
                Divider().padding(.vertical, 8)
                Text("Current Allocation").font(.headline)
                ForEach(summary.allocations) { alloc in
                    HStack {
                        Text(alloc.name)
                        Spacer()
                        Text(String(format: "%.1f%%", alloc.percentage))
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
    }
}

/// A section for displaying all individual ETF result cards.
struct IndividualResultsSection: View {
    let results: [ETFAnalysisResult]
    @Binding var expandedETFs: Set<UUID>
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Individual Performance")
                    .font(.title2).bold()
                Spacer()
                Button(expandedETFs.isEmpty ? "Expand All" : "Collapse All") {
                    withAnimation(.spring) {
                        if expandedETFs.isEmpty {
                            expandedETFs = Set(results.map { $0.id })
                        } else {
                            expandedETFs.removeAll()
                        }
                    }
                }
                .font(.caption).bold()
            }
            
            ForEach(results) { result in
                ETFResultCard(result: result, isExpanded: expandedETFs.contains(result.id)) {
                    withAnimation(.spring) {
                        if expandedETFs.contains(result.id) {
                            expandedETFs.remove(result.id)
                        } else {
                            expandedETFs.insert(result.id)
                        }
                    }
                }
            }
        }
    }
}

/// **V9 REFACTOR**: A more robust card for displaying an ETF's results.
/// Uses standard layout techniques for better stability.
struct ETFResultCard: View {
    let result: ETFAnalysisResult
    let isExpanded: Bool
    let onToggle: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Header (always visible, acts as the toggle button)
            headerView
            
            // Collapsible content
            if isExpanded {
                Divider()
                detailView
                    .padding()
            }
        }
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .contentShape(Rectangle()) // Makes the whole card tappable
        .onTapGesture(perform: onToggle)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(result.name).font(.headline).bold()
                Spacer()
                Text(result.netReturnDollars.formattedAsCurrencySigned())
                    .font(.headline.monospacedDigit())
                    .foregroundColor(result.netReturnDollars >= 0 ? .green : .red)
            }
            HStack {
                Text("\(result.initialInvestment.formattedAsCurrency()) → \(result.currentValueCapitalOnly.formattedAsCurrency())")
                Spacer()
                Text("\(String(format: "%.2f%%", result.annualizedTotalReturnPct)) annual")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var detailView: some View {
        VStack(spacing: 8) {
            DetailRow(label: "Holding Period", value: "\(result.daysHeld) days")
            DetailRow(label: "Capital Gain/Loss", value: result.capitalAppreciationDollars.formattedAsCurrencySigned())
            DetailRow(label: "Dividend Income", value: result.totalYieldIncomeDollars.formattedAsCurrency())
            DetailRow(label: "Est. Expense Cost", value: "(\(result.totalExpenseDollars.formattedAsCurrency()))")
            Divider()
            DetailRow(label: "Net Return", value: result.netReturnDollars.formattedAsCurrencySigned(), isHighlighted: true)
        }
    }
}

// MARK: - Helper Views & Modifiers
/// A reusable view for displaying a key-value pair in a row.
struct MetricRow: View {
    let label: String
    let value: String
    var valueColor: Color = .primary
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(.secondary)
            Spacer()
            Text(value).fontWeight(.semibold).foregroundColor(valueColor)
        }
    }
}

/// A reusable view for displaying a detailed key-value pair.
struct DetailRow: View {
    let label: String
    let value: String
    var isHighlighted: Bool = false
    
    var body: some View {
        HStack {
            Text(label).foregroundColor(.secondary)
            Spacer()
            Text(value).fontWeight(isHighlighted ? .bold : .regular)
        }
        .font(.subheadline)
    }
}

/// A view modifier for consistent action button styling.
struct ActionButtonStyle: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(12)
    }
}

// MARK: - Preview Provider
/// Provides a preview of the `ContentView` for Xcode's canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
