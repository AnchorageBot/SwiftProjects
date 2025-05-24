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

struct ContentView: View {
    @StateObject private var viewModel = PortfolioViewModel()
    @State private var showingResults = false
    
    var body: some View {
        NavigationStack {
            PortfolioSetupView(viewModel: viewModel)
                .navigationTitle("ETF Portfolio Analyzer")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !viewModel.individualResults.isEmpty {
                            Button("View Results") {
                                showingResults = true
                            }
                        }
                    }
                }
                .navigationDestination(isPresented: $showingResults) {
                    ResultsView(viewModel: viewModel)
                }
        }
    }
}

// Main setup view with navigation to individual ETF inputs
struct PortfolioSetupView: View {
    @ObservedObject var viewModel: PortfolioViewModel
    
    var body: some View {
        List {
            Section {
                Stepper("Number of ETFs: \(viewModel.numberOfETFs)",
                       value: $viewModel.numberOfETFs,
                       in: 1...10)
                    .onChange(of: viewModel.numberOfETFs) {
                        viewModel.clearResults()
                    }
            } header: {
                Text("Portfolio Setup")
            }
            
            Section {
                ForEach(viewModel.etfInputs.indices, id: \.self) { index in
                    NavigationLink(destination: ETFDetailInputView(
                        etfInput: $viewModel.etfInputs[index],
                        etfNumber: index + 1
                    )) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("ETF #\(index + 1)")
                                    .font(.headline)
                                if !viewModel.etfInputs[index].name.isEmpty {
                                    Text(viewModel.etfInputs[index].name)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
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
            
            Section {
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

// Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
