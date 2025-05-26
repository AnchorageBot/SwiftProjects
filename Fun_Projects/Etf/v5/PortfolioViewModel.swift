//
// ETF_v5
// PortfolioViewModel.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
// Simplified to v5 by Claude (Anthropic) on 5/26/25
//

import Foundation
import Combine

// MARK: - Portfolio View Model
/// Simplified view model that manages portfolio state and calculations
/// Focuses on essential functionality without unnecessary complexity
class PortfolioViewModel: ObservableObject {
    // MARK: - Published Properties
    /// Array of ETF inputs - automatically sized based on numberOfETFs
    @Published var etfInputs: [ETFInput] = [ETFInput()]
    
    /// Calculation results for each ETF
    @Published var individualResults: [ETFAnalysisResult] = []
    
    /// Aggregated portfolio summary
    @Published var portfolioSummary: PortfolioSummaryResult? = nil
    
    /// Number of ETFs in the portfolio (1-10)
    @Published var numberOfETFs: Int = 1 {
        didSet {
            adjustETFInputsArray()
        }
    }

    // MARK: - Private Properties
    /// Calculator instance for financial calculations
    private let calculator = PortfolioCalculator()

    // MARK: - Computed Properties
    /// Validates all ETF inputs are complete and valid
    var allInputsValid: Bool {
        !etfInputs.isEmpty && etfInputs.allSatisfy { $0.isValid }
    }

    // MARK: - Public Methods
    /// Performs analysis on all ETFs and generates results
    func analyze() {
        guard allInputsValid else {
            print("Portfolio analysis skipped - invalid inputs")
            return
        }

        // Calculate results for each ETF
        var results: [ETFAnalysisResult] = []
        for input in etfInputs {
            if let result = calculator.analyzeETF(etfInput: input) {
                results.append(result)
            }
        }
        
        // Update results
        self.individualResults = results
        self.portfolioSummary = calculator.analyzePortfolio(etfResultsList: results)
    }
    
    /// Clears all data and resets to initial state
    func clearAll() {
        // Reset to single empty ETF
        numberOfETFs = 1
        etfInputs = [ETFInput()]
        individualResults = []
        portfolioSummary = nil
    }
    
    // MARK: - Private Methods
    /// Adjusts the ETF inputs array when numberOfETFs changes
    private func adjustETFInputsArray() {
        if numberOfETFs > etfInputs.count {
            // Add new empty ETFs
            let etfsToAdd = numberOfETFs - etfInputs.count
            for _ in 0..<etfsToAdd {
                etfInputs.append(ETFInput())
            }
        } else if numberOfETFs < etfInputs.count {
            // Remove excess ETFs
            etfInputs.removeLast(etfInputs.count - numberOfETFs)
        }
        
        // Clear results when ETF count changes
        individualResults = []
        portfolioSummary = nil
    }
}
