//
// ETF_v3
// ContentView.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import SwiftUI

// MARK: - Main Content View
/// The root view of the application that sets up the navigation structure
/// and manages the portfolio view model as the single source of truth
struct ContentView: View {
    // MARK: - Properties
    /// @StateObject creates and owns the view model instance
    /// This ensures the view model persists for the lifetime of this view
    @StateObject private var viewModel = PortfolioViewModel()
    
    /// @State property to control navigation to results view
    /// When true, navigates to the ResultsView
    @State private var showingResults = false
    
    // MARK: - Body
    var body: some View {
        // NavigationStack provides the navigation container for iOS 16+
        // It replaces NavigationView with better programmatic navigation
        NavigationStack {
            // Main portfolio setup view
            PortfolioSetupView(viewModel: viewModel)
                .navigationTitle("ETF Portfolio Analyzer")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    // Show "View Results" button only when results are available
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !viewModel.individualResults.isEmpty {
                            Button("View Results") {
                                showingResults = true
                            }
                        }
                    }
                }
                // Programmatic navigation to results view
                .navigationDestination(isPresented: $showingResults) {
                    ResultsView(viewModel: viewModel)
                }
        }
    }
}

// MARK: - Portfolio Setup View
/// Main view for configuring the portfolio
/// Displays ETF count stepper, list of ETFs, and analyze button
struct PortfolioSetupView: View {
    // MARK: - Properties
    /// @ObservedObject receives the view model from parent
    /// Changes to the view model will update this view
    @ObservedObject var viewModel: PortfolioViewModel
    
    // MARK: - Body
    var body: some View {
        // List provides scrollable content with platform-appropriate styling
        List {
            // MARK: Portfolio Configuration Section
            Section {
                // Stepper allows users to select number of ETFs (1-10)
                Stepper("Number of ETFs: \(viewModel.numberOfETFs)", 
                       value: $viewModel.numberOfETFs, 
                       in: 1...10)
                    // Clear results when ETF count changes
                    .onChange(of: viewModel.numberOfETFs) {
                        viewModel.clearResults()
                    }
            } header: {
                Text("Portfolio Setup")
            }
            
            // MARK: ETF Details Section
            Section {
                // ForEach creates a row for each ETF
                // Using indices to access binding to array elements
                ForEach(viewModel.etfInputs.indices, id: \.self) { index in
                    // NavigationLink provides navigation to detail view
                    NavigationLink(destination: ETFDetailInputView(
                        etfInput: $viewModel.etfInputs[index],
                        etfNumber: index + 1
                    )) {
                        HStack {
                            // ETF information
                            VStack(alignment: .leading) {
                                Text("ETF #\(index + 1)")
                                    .font(.headline)
                                // Show ETF name if entered
                                if !viewModel.etfInputs[index].name.isEmpty {
                                    Text(viewModel.etfInputs[index].name)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            // Validation indicator
                            if viewModel.etfInputs[index].isValid {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "exclamationmark.circle")
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                }
            } header: {
                Text("ETF Details")
            } footer: {
                Text("Tap each ETF to enter its details")
                    .font(.caption)
            }
            
            // MARK: Actions Section
            Section {
                // Analyze button - disabled until all inputs are valid
                Button(action: {
                    viewModel.analyze()
                }) {
                    HStack {
                        Spacer()
                        Text("Analyze Portfolio")
                            .fontWeight(.medium)
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.allInputsValid)
                
                // Show navigation to results if analysis has been performed
                if !viewModel.individualResults.isEmpty {
                    NavigationLink(destination: ResultsView(viewModel: viewModel)) {
                        HStack {
                            Text("View Results")
                            Spacer()
                            Image(systemName: "chart.line.uptrend.xyaxis")
                        }
                    }
                }
            }
            
            // MARK: Clear Results Section
            // Only show when results exist
            if !viewModel.individualResults.isEmpty {
                Section {
                    Button("Clear Results") {
                        viewModel.clearResults()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
}

// MARK: - Preview Provider
/// Provides previews for SwiftUI canvas in Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Light mode preview
        ContentView()
            .preferredColorScheme(.light)
        // Dark mode preview
        ContentView()
            .preferredColorScheme(.dark)
    }
}
