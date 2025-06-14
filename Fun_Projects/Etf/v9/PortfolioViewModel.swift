//
// ETF_v9
// PortfolioViewModel.swift
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

import Foundation
import Combine

/// The central state manager for the portfolio, conforming to `ObservableObject`
/// to allow SwiftUI views to subscribe to its changes.
class PortfolioViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// `@Published` properties automatically notify any subscribing views when their values change.
    
    /// The array of `ETFInput` objects, one for each ETF the user wants to track.
    /// This is the primary source of truth for user-entered data.
    @Published var etfInputs: [ETFInput] = [ETFInput()]
    
    /// The array of `ETFAnalysisResult` objects, populated after the user taps "Analyze".
    @Published var individualResults: [ETFAnalysisResult] = []
    
    /// The `PortfolioSummaryResult` object, also populated after analysis.
    @Published var portfolioSummary: PortfolioSummaryResult? = nil
    
    /// The number of ETFs the user wants to manage, controlled by a `Stepper`.
    /// The `didSet` observer calls `updateETFCount()` to adjust the `etfInputs` array accordingly.
    @Published var numberOfETFs: Int = 1 {
        didSet {
            updateETFCount()
        }
    }

    // MARK: - Private Properties
    /// An instance of the calculator struct, which contains all the pure business logic.
    private let calculator = PortfolioCalculator()

    // MARK: - Computed Properties
    /// A computed property that checks if all ETFs in the `etfInputs` array are valid.
    /// It is used to enable or disable the "Analyze Portfolio" button.
    var allInputsValid: Bool {
        !etfInputs.isEmpty && etfInputs.allSatisfy { $0.isValid }
    }

    // MARK: - Public Methods
    /// Triggers the full portfolio analysis process.
    /// This function is called when the "Analyze" button is pressed.
    func analyze() {
        // Ensure all inputs are valid before proceeding.
        guard allInputsValid else {
            print("Analysis aborted: Not all ETF inputs are valid.")
            return
        }

        // Use `compactMap` to iterate through all user inputs, analyze each one,
        // and create an array of valid `ETFAnalysisResult` objects.
        let results = etfInputs.compactMap { calculator.analyzeETF(etfInput: $0) }
        
        // Once individual results are calculated, generate the portfolio-wide summary.
        let summary = calculator.analyzePortfolio(etfResultsList: results)
        
        // Update the published properties on the main thread. SwiftUI requires UI updates
        // to happen on the main actor.
        DispatchQueue.main.async {
            self.individualResults = results
            self.portfolioSummary = summary
        }
    }
    
    /// Resets the entire application state to its default.
    func clearAll() {
        DispatchQueue.main.async {
            self.numberOfETFs = 1
            self.etfInputs = [ETFInput()]
            self.individualResults = []
            self.portfolioSummary = nil
        }
    }
    
    // MARK: - Private Methods
    /// Adjusts the size of the `etfInputs` array to match `numberOfETFs`.
    private func updateETFCount() {
        // If the user increases the number of ETFs, add new, empty `ETFInput` instances.
        if numberOfETFs > etfInputs.count {
            let newETFsNeeded = numberOfETFs - etfInputs.count
            for _ in 0..<newETFsNeeded {
                etfInputs.append(ETFInput())
            }
        // If the user decreases the number, remove the excess ones from the end.
        } else if numberOfETFs < etfInputs.count {
            etfInputs.removeLast(etfInputs.count - numberOfETFs)
        }
        
        // Any change in the number of ETFs should clear previous results.
        individualResults = []
        portfolioSummary = nil
    }
}
