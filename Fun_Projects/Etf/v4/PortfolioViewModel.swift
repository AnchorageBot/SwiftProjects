//
// ETF_v3
// PortfolioViewModel.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import Foundation
import Combine

// MARK: - Portfolio View Model
/// The main view model that manages the portfolio state and calculations
/// Conforms to ObservableObject to enable SwiftUI view updates
class PortfolioViewModel: ObservableObject {
    // MARK: - Published Properties
    /// Array of ETF input models, one for each ETF in the portfolio
    /// @Published ensures views update when this changes
    @Published var etfInputs: [ETFInput] = [ETFInput()]
    
    /// Array of calculation results for each ETF
    /// Empty until analyze() is called
    @Published var individualResults: [ETFAnalysisResult] = []
    
    /// Aggregated portfolio summary
    /// nil until analyze() is called with valid inputs
    @Published var portfolioSummary: PortfolioSummaryResult? = nil
    
    /// Number of ETFs in the portfolio (1-10)
    /// Changing this value automatically adjusts the etfInputs array
    @Published var numberOfETFs: Int = 1 {
        didSet {
            // Adjust the etfInputs array size when numberOfETFs changes
            if numberOfETFs > etfInputs.count {
                // Add new empty ETF inputs
                for _ in 0..<(numberOfETFs - etfInputs.count) {
                    etfInputs.append(ETFInput())
                }
            } else if numberOfETFs < etfInputs.count {
                // Remove excess ETF inputs from the end
                etfInputs.removeLast(etfInputs.count - numberOfETFs)
            }
        }
    }

    // MARK: - Private Properties
    /// Calculator instance that performs all financial calculations
    private let calculator = PortfolioCalculator()

    // MARK: - Computed Properties
    /// Checks if all ETF inputs are valid and ready for analysis
    var allInputsValid: Bool {
        // Must have at least one ETF and all must be valid
        !etfInputs.isEmpty && etfInputs.allSatisfy { $0.isValid }
    }

    // MARK: - Methods
    /// Performs analysis on all ETFs and generates results
    /// Only executes if all inputs are valid
    func analyze() {
        // Validate inputs before proceeding
        guard allInputsValid else {
            print("Inputs are not valid")
            // Clear any existing results
            self.individualResults = []
            self.portfolioSummary = nil
            return
        }

        // Calculate results for each ETF
        var results: [ETFAnalysisResult] = []
        for input in etfInputs {
            // analyzeETF returns nil if input is invalid (shouldn't happen here)
            if let result = calculator.analyzeETF(etfInput: input) {
                results.append(result)
            }
        }
        
        // Update published properties to trigger view updates
        self.individualResults = results
        self.portfolioSummary = calculator.analyzePortfolio(etfResultsList: results)
    }
    
    /// Clears all analysis results
    /// Called when inputs change or user requests reset
    func clearResults() {
        self.individualResults = []
        self.portfolioSummary = nil
    }
}
