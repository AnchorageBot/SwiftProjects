//
// ETF_v9
// Models.swift
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

// MARK: - ETF Input Model
/// Stores all the raw data entered by the user for a single ETF.
/// This struct is bound to the UI in `ETFDetailScreen`.
struct ETFInput: Identifiable {
    // MARK: Properties
    
    /// A unique identifier for each ETF instance, essential for SwiftUI's `ForEach` loops.
    let id = UUID()
    
    /// The name or ticker symbol of the ETF (e.g., "VTI", "SPY").
    var name: String = ""
    
    // MARK: Direct Numeric Properties
    
    /// The ETF's expense ratio, entered as a percentage (e.g., 0.03 for 0.03%).
    var expenseRatioPercent: Double = 0.0
    
    /// The ETF's annual dividend yield, entered as a percentage (e.g., 1.5 for 1.5%).
    var annualYieldPercent: Double = 0.0
    
    /// The total number of shares the user owns.
    var shares: Double = 0.0
    
    /// The price per share at the time of purchase.
    var startPrice: Double = 0.0
    
    /// The current price per share for analysis.
    var endPrice: Double = 0.0
    
    // MARK: Date Properties
    
    /// The date the ETF was purchased.
    var startDate: Date = Date()
    
    /// The date for which the analysis is being performed (typically today).
    var endDate: Date = Date()

    // MARK: Computed Properties
    
    /// A computed property that validates all user-provided data.
    /// The "Analyze" button is enabled only when all inputs are valid.
    var isValid: Bool {
        // 1. Name must not be just whitespace.
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        // 2. Financial metrics must be non-negative.
        expenseRatioPercent >= 0 &&
        annualYieldPercent >= 0 &&
        // 3. Core investment details must be positive numbers.
        shares > 0 &&
        startPrice > 0 &&
        endPrice > 0 &&
        // 4. The analysis date cannot be before the purchase date.
        endDate >= startDate
    }
}

// MARK: - ETF Analysis Result Model
/// Holds all the calculated performance metrics for a single ETF after analysis.
struct ETFAnalysisResult: Identifiable {
    // MARK: Properties
    
    /// Unique identifier for use in SwiftUI lists.
    let id = UUID()
    
    /// The name of the ETF, carried over from `ETFInput`.
    let name: String
    
    /// The total number of days the investment has been held.
    let daysHeld: Int
    
    /// The total initial cost of the investment (`shares * startPrice`).
    let initialInvestment: Double
    
    /// The current market value of the investment, based on capital appreciation only (`shares * endPrice`).
    let currentValueCapitalOnly: Double
    
    /// The profit or loss from the change in share price alone.
    let capitalAppreciationDollars: Double
    
    /// The dividend yield percentage, carried over from `ETFInput`.
    let annualYieldPercentInput: Double
    
    /// The estimated total income from dividends over the holding period.
    let totalYieldIncomeDollars: Double
    
    /// The total return before deducting any expenses (`capitalAppreciation + totalYieldIncome`).
    let totalReturnDollarsGross: Double
    
    /// The annualized return (CAGR), including capital gains and dividends, as a percentage.
    let annualizedTotalReturnPct: Double
    
    /// The estimated total cost from the expense ratio over the holding period.
    let totalExpenseDollars: Double
    
    /// The final net return after subtracting expenses from the gross return. This is the "bottom line" result.
    let netReturnDollars: Double
}

// MARK: - Portfolio Summary Model
/// Aggregates the results from all individual ETFs into a total portfolio view.
struct PortfolioSummaryResult {
    // MARK: Portfolio Totals
    
    /// The sum of all initial investments across all ETFs.
    var initialInvestment: Double = 0.0
    
    /// The sum of the current market values of all ETFs.
    var currentValueCapitalOnly: Double = 0.0
    
    /// The total capital appreciation for the entire portfolio.
    var capitalAppreciationDollars: Double = 0.0
    
    /// The total dividend income from all ETFs combined.
    var totalYieldIncomeDollars: Double = 0.0
    
    /// The total gross return for the portfolio before expenses.
    var totalReturnDollarsGross: Double = 0.0
    
    /// The total fees paid across all ETFs.
    var totalExpenseDollars: Double = 0.0
    
    /// The final net return for the entire portfolio after all costs.
    var netReturnDollars: Double = 0.0
    
    /// The weighted average annualized return of the portfolio, based on the initial investment of each ETF.
    var weightedAnnualizedTotalReturnPct: Double = 0.0
    
    /// A list of each ETF's current percentage of the total portfolio value.
    var allocations: [PortfolioAllocation] = []
}

// MARK: - Portfolio Allocation Model
/// Represents a single ETF's percentage share of the total portfolio.
struct PortfolioAllocation: Identifiable {
    /// Unique identifier for use in SwiftUI lists.
    let id = UUID()
    
    /// The name of the ETF.
    let name: String
    
    /// The ETF's percentage of the total portfolio's current value (e.g., 45.5 for 45.5%).
    let percentage: Double
}

// MARK: - Double Extension for Currency Formatting
/// An extension on the `Double` type to provide easy and consistent currency formatting.
extension Double {
    /// Formats a `Double` into a standard currency string (e.g., "$1,234.56").
    /// Uses the user's local currency settings.
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "$%.2f", self)
    }

    /// Formats a `Double` into a currency string with an explicit sign (e.g., "+$250.00" or "-$50.00").
    /// This is useful for displaying gains and losses clearly.
    func formattedAsCurrencySigned() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        // Add a "+" sign for positive numbers. The "-" sign is added automatically for negative numbers.
        formatter.positivePrefix = "+" + (formatter.currencySymbol ?? "$")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%@$%.2f", self >= 0 ? "+" : "", abs(self))
    }
}
