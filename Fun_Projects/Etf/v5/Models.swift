//
// ETF_v5
// Models.swift
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

// MARK: - ETF Input Model
/// Simplified input model using direct numeric properties
/// Eliminates string-to-double conversion complexity
struct ETFInput: Identifiable {
    // MARK: Properties
    /// Unique identifier for SwiftUI list operations
    let id = UUID()
    
    /// ETF ticker symbol or name (e.g., "VTI", "QQQ")
    var name: String = ""
    
    // MARK: Direct Numeric Properties
    /// All numeric inputs now stored directly as doubles
    /// SwiftUI TextField handles the conversion automatically
    var expenseRatioPercent: Double = 0.0    // Expense ratio as percentage (0.03 = 0.03%)
    var annualYieldPercent: Double = 0.0     // Annual yield as percentage (1.5 = 1.5%)
    var shares: Double = 0.0                 // Number of shares owned
    var startPrice: Double = 0.0             // Purchase price per share
    var endPrice: Double = 0.0               // Current/analysis price per share
    
    // MARK: Date Properties
    /// Purchase date of the ETF
    var startDate: Date = Date()
    
    /// Analysis/current date for calculations
    var endDate: Date = Date()

    // MARK: Computed Properties
    /// Simplified validation - checks that all required fields have valid values
    var isValid: Bool {
        // Name must not be empty
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        // All numeric values must be positive (expense ratio can be 0)
        expenseRatioPercent >= 0 &&
        annualYieldPercent >= 0 &&
        shares > 0 &&
        startPrice > 0 &&
        endPrice > 0 &&
        // End date must not be before start date
        endDate >= startDate
    }
}

// MARK: - ETF Analysis Result Model
/// Contains the calculated results for a single ETF investment
/// All monetary values are in dollars, percentages are as whole numbers
struct ETFAnalysisResult: Identifiable {
    // MARK: Properties
    let id = UUID()
    
    /// ETF name/ticker from input
    let name: String
    
    /// Number of days between purchase and analysis dates
    let daysHeld: Int
    
    /// Initial investment amount (shares × start price)
    let initialInvestment: Double
    
    /// Current value based on price appreciation only
    let currentValueCapitalOnly: Double
    
    /// Change in value from price movement
    let capitalAppreciationDollars: Double
    
    /// Annual yield percentage (from input)
    let annualYieldPercentInput: Double
    
    /// Estimated total dividend/yield income
    let totalYieldIncomeDollars: Double
    
    /// Total return before expenses
    let totalReturnDollarsGross: Double
    
    /// Annualized return percentage
    let annualizedTotalReturnPct: Double
    
    /// Total expense cost over holding period
    let totalExpenseDollars: Double
    
    /// Net return after all expenses
    let netReturnDollars: Double
}

// MARK: - Portfolio Summary Model
/// Aggregated results for the entire portfolio
struct PortfolioSummaryResult {
    // MARK: Portfolio Totals
    /// Sum of all initial investments
    var initialInvestment: Double = 0.0
    
    /// Sum of all current values (capital only)
    var currentValueCapitalOnly: Double = 0.0
    
    /// Total capital appreciation across all ETFs
    var capitalAppreciationDollars: Double = 0.0
    
    /// Total yield income across all ETFs
    var totalYieldIncomeDollars: Double = 0.0
    
    /// Total gross return across all ETFs
    var totalReturnDollarsGross: Double = 0.0
    
    /// Total expenses across all ETFs
    var totalExpenseDollars: Double = 0.0
    
    /// Total net return across all ETFs
    var netReturnDollars: Double = 0.0
    
    /// Weighted average annualized return percentage
    var weightedAnnualizedTotalReturnPct: Double = 0.0
    
    /// Current allocation percentages for each ETF
    var allocations: [PortfolioAllocation] = []
}

// MARK: - Portfolio Allocation Model
/// Represents a single ETF's allocation within the portfolio
struct PortfolioAllocation: Identifiable {
    let id = UUID()
    
    /// ETF name/ticker
    let name: String
    
    /// Percentage of total portfolio value (0-100)
    let percentage: Double
}

// MARK: - Currency Formatting Extension
/// Provides convenient currency formatting methods for Double values
extension Double {
    /// Formats the value as currency (e.g., $1,234.56)
    /// Uses the device's locale for currency symbol and formatting
    func formattedAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "$%.2f", self)
    }

    /// Formats the value as signed currency with explicit + or - sign
    /// Positive values show "+$1,234.56", negative show "-$567.89"
    func formattedAsCurrencySigned() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        // Always show sign for both positive and negative
        formatter.positivePrefix = "+" + (formatter.currencySymbol ?? "$")
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%@$%.2f", self >= 0 ? "+" : "", abs(self))
    }
}
