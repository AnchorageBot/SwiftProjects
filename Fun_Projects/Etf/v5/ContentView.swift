//
// ETF_v5
// ContentView.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
// Simplified to v5 by Claude (Anthropic) on 5/26/25
//

import SwiftUI

// MARK: - Main Content View
/// The root view of the application with simplified navigation
/// Uses a single scrollable view instead of complex navigation hierarchy
struct ContentView: View {
    // MARK: - Properties
    /// @StateObject creates and owns the view model instance
    /// This ensures the view model persists for the lifetime of this view
    @StateObject private var viewModel = PortfolioViewModel()
    
    /// Controls whether to show analysis results
    /// When false, shows input section; when true, shows results
    @State private var showingResults = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Show either input section or results based on state
                    if !showingResults {
                        // MARK: Input Section
                        PortfolioInputSection(viewModel: viewModel)
                        
                        // Analyze button
                        Button(action: {
                            viewModel.analyze()
                            withAnimation {
                                showingResults = true
                            }
                        }) {
                            Text("Analyze Portfolio")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(!viewModel.allInputsValid)
                        .padding(.horizontal)
                        
                    } else {
                        // MARK: Results Section
                        UnifiedResultsView(viewModel: viewModel)
                        
                        // Button to go back to inputs
                        Button(action: {
                            withAnimation {
                                showingResults = false
                            }
                        }) {
                            Text("Modify Inputs")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.secondary.opacity(0.2))
                                .foregroundColor(.primary)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("ETF Portfolio Analyzer")
            .toolbar {
                // Clear button in toolbar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear") {
                        viewModel.clearAll()
                        showingResults = false
                    }
                }
            }
        }
    }
}

// MARK: - Portfolio Input Section
/// Displays all ETF inputs in a single scrollable view
/// No navigation required - everything is visible at once
struct PortfolioInputSection: View {
    // MARK: - Properties
    @ObservedObject var viewModel: PortfolioViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            // MARK: Portfolio Setup Card
            VStack(alignment: .leading, spacing: 12) {
                Text("Portfolio Setup")
                    .font(.headline)
                
                // Number of ETFs stepper
                Stepper("Number of ETFs: \(viewModel.numberOfETFs)", 
                       value: $viewModel.numberOfETFs, 
                       in: 1...10)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // MARK: ETF Input Cards
            ForEach(viewModel.etfInputs.indices, id: \.self) { index in
                ETFInputCard(
                    etfInput: $viewModel.etfInputs[index],
                    etfNumber: index + 1
                )
            }
        }
    }
}

// MARK: - ETF Input Card
/// A compact card view for entering ETF data
/// All inputs visible at once - no need to navigate to separate screens
struct ETFInputCard: View {
    // MARK: - Properties
    @Binding var etfInput: ETFInput
    let etfNumber: Int
    
    /// Number formatter for decimal input fields
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    /// Number formatter for currency input fields
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header with ETF number and validation status
            HStack {
                Text("ETF #\(etfNumber)")
                    .font(.headline)
                
                Spacer()
                
                // Validation indicator
                if etfInput.isValid {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if !etfInput.name.isEmpty {
                    Image(systemName: "exclamationmark.circle")
                        .foregroundColor(.orange)
                }
            }
            
            // MARK: Input Grid
            // Using a grid layout for more compact display
            VStack(spacing: 12) {
                // ETF Name
                HStack {
                    Text("Name:")
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    TextField("e.g., VTI", text: $etfInput.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Expense Ratio & Annual Yield
                HStack(spacing: 16) {
                    HStack {
                        Text("Expense:")
                            .foregroundColor(.secondary)
                            .frame(width: 70, alignment: .leading)
                        TextField("0.03", value: $etfInput.expenseRatioPercent, formatter: decimalFormatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        Text("%")
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Yield:")
                            .foregroundColor(.secondary)
                            .frame(width: 50, alignment: .leading)
                        TextField("1.5", value: $etfInput.annualYieldPercent, formatter: decimalFormatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                        Text("%")
                            .foregroundColor(.secondary)
                    }
                }
                
                // Shares & Start Price
                HStack(spacing: 16) {
                    HStack {
                        Text("Shares:")
                            .foregroundColor(.secondary)
                            .frame(width: 70, alignment: .leading)
                        TextField("100", value: $etfInput.shares, formatter: decimalFormatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Buy $:")
                            .foregroundColor(.secondary)
                            .frame(width: 50, alignment: .leading)
                        TextField("150.00", value: $etfInput.startPrice, formatter: currencyFormatter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                }
                
                // Dates
                DatePicker("Purchase Date:", selection: $etfInput.startDate, displayedComponents: .date)
                    .foregroundColor(.secondary)
                
                // Current Price
                HStack {
                    Text("Current $:")
                        .foregroundColor(.secondary)
                        .frame(width: 100, alignment: .leading)
                    TextField("175.00", value: $etfInput.endPrice, formatter: currencyFormatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                
                DatePicker("Analysis Date:", selection: $etfInput.endDate, displayedComponents: .date)
                    .foregroundColor(.secondary)
            }
            
            // MARK: Quick Preview
            // Show calculated values if inputs are valid
            if etfInput.isValid {
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Initial: \((etfInput.shares * etfInput.startPrice).formattedAsCurrency())")
                            .font(.caption)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        let gain = (etfInput.shares * etfInput.endPrice) - (etfInput.shares * etfInput.startPrice)
                        Text("Gain/Loss: \(gain.formattedAsCurrencySigned())")
                            .font(.caption)
                            .foregroundColor(gain >= 0 ? .green : .red)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
