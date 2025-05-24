//
// ETF_v3
// Models.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import Foundation

// Input data for a single ETF
struct ETFInput: Identifiable {
    let id = UUID()
    var name: String = ""
    var expenseRatioPercentString: String = ""
    var annualYieldPercentString: String = ""
    var sharesString: String = ""
    var startPriceString: String = ""
    var startDate: Date = Date()
    var endPriceString: String = ""
    var endDate: Date = Date()

    // Computed properties for validated numbers
    var expenseRatioPercent: Double? { Double(expenseRatioPercentString) }
    var annualYieldPercent: Double? { Double(annualYieldPercentString) }
    var shares: Double? { Double(sharesString) }
    var startPrice: Double? { Double(startPriceString) }
    var endPrice: Double? { Double(endPriceString) }

    var isValid: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
        expenseRatioPercent != nil && expenseRatioPercent! >= 0 &&
        annualYieldPercent != nil && annualYieldPercent! >= 0 &&
        shares != nil && shares! > 0 &&
        startPrice != nil && startPrice! > 0 &&
        endPrice != nil && endPrice! >= 0 &&
        endDate >= startDate
    }
}

// Analysis results for a single ETF
struct ETFAnalysisResult: Identifiable {
    let id = UUID()
    let name: String
    let daysHeld: Int
    let initialInvestment: Double
    let currentValueCapitalOnly: Double
    let capitalAppreciationDollars: Double
    let annualYieldPercentInput: Double
    let totalYieldIncomeDollars: Double
    let totalReturnDollarsGross: Double
    let annualizedTotalReturnPct: Double
    let totalExpenseDollars: Double
    let netReturnDollars: Double
}

// Portfolio summary
struct PortfolioSummaryResult {
    var initialInvestment: Double = 0.0
    var currentValueCapitalOnly: Double = 0.0
    var capitalAppreciationDollars: Double = 0.0
    var totalYieldIncomeDollars: Double = 0.0
    var totalReturnDollarsGross: Double = 0.0
    var totalExpenseDollars: Double = 0.0
    var netReturnDollars: Double = 0.0
    var weightedAnnualizedTotalReturnPct: Double = 0.0
    var allocations: [PortfolioAllocation] = []
}

struct PortfolioAllocation: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Double
}

// Extension for currency formatting
extension Double {
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "$%.2f", self)
    }

    func formattedAsCurrencySigned() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.positivePrefix = formatter.plusSign
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%@%.2f", self >= 0 ? "+" : "", self)
    }
}
