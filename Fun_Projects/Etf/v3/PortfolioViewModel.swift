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

class PortfolioViewModel: ObservableObject {
    @Published var etfInputs: [ETFInput] = [ETFInput()]
    @Published var individualResults: [ETFAnalysisResult] = []
    @Published var portfolioSummary: PortfolioSummaryResult? = nil
    @Published var numberOfETFs: Int = 1 {
        didSet {
            // Adjust the etfInputs array size
            if numberOfETFs > etfInputs.count {
                for _ in 0..<(numberOfETFs - etfInputs.count) {
                    etfInputs.append(ETFInput())
                }
            } else if numberOfETFs < etfInputs.count {
                etfInputs.removeLast(etfInputs.count - numberOfETFs)
            }
        }
    }

    private let calculator = PortfolioCalculator()

    var allInputsValid: Bool {
        !etfInputs.isEmpty && etfInputs.allSatisfy { $0.isValid }
    }

    func analyze() {
        guard allInputsValid else {
            print("Inputs are not valid")
            self.individualResults = []
            self.portfolioSummary = nil
            return
        }

        var results: [ETFAnalysisResult] = []
        for input in etfInputs {
            if let result = calculator.analyzeETF(etfInput: input) {
                results.append(result)
            }
        }
        self.individualResults = results
        self.portfolioSummary = calculator.analyzePortfolio(etfResultsList: results)
    }
    
    func clearResults() {
        self.individualResults = []
        self.portfolioSummary = nil
    }
}
