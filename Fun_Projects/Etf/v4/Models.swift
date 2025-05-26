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

// MARK: - ETF Input Model
/// Represents the input data for a single ETF investment
/// Uses string properties for text fields to handle user input gracefully
struct ETFInput: Identifiable {
    // MARK: Properties
    /// Unique identifier for SwiftUI list operations
    let id = UUID()
    
    /// ETF ticker symbol or name (e.g., "VTI", "QQQ")
    var name: String = ""
    
    // MARK: String Properties for Text Fields
    /// These properties store raw user input as strings
    /// Allows for graceful handling of invalid input
    var expenseRatioPercentString: String = ""  // Expected format: "0.03" for 0.03%
    var annualYieldPercentString: String = ""   // Expected format: "1.5" for 1.5%
    var sharesString: String = ""               // Expected format: "100" for 100 shares
    var startPriceString: String = ""           // Expected format: "150.50" for $150.50
    var endPriceString: String = ""             // Expected format: "175.25" for $175.25
    
    // MARK: Date Properties
    /// Purchase date of the ETF
    var startDate: Date = Date()
    
    /// Analysis/current date for calculations
    var endDate: Date = Date()

    // MARK: Computed Properties
    /// Safely converts string inputs to Double values
    /// Returns nil if conversion fails (invalid input)
    var expenseRatioPercent: Double? { Double(expenseRatioPercentString) }
    var annualYieldPercent: Double? { Double(annualYieldPercentString) }
    var shares: Double? { Double(sharesString) }
    var startPrice: Double? { Double(startPriceString) }
    var endPrice: Double? { Double(endPriceString) }

    /// Validates all input fields
    /// Returns true only if all fields contain valid data
    var isValid: Bool {
        // Check name is not empty (after trimming whitespace)
        name.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
        // Check all numeric fields can be converted and have valid values
        expenseRatioPercent != nil && expenseRatioPercent! >= 0 &&
        annualYieldPercent != nil && annualYieldPercent! >= 0 &&
        shares != nil && shares! > 0 &&
        startPrice != nil && startPrice! > 0 &&
        endPrice != nil && endPrice! >= 0 &&
        // Check end date is not before start date
        endDate >= startDate
    }
}

// MARK: - ETF Analysis Result Model
/// Contains the calculated results for a single ETF investment
/// All monetary values are in dollars, percentages are as whole numbers (e.g., 5.0 = 5%)
struct ETFAnalysisResult: Identifiable {
    // MARK: Properties
    let id = UUID()
    
    /// ETF name/ticker from input
    let name: String
    
    /// Number of days between start and end dates
    let daysHeld: Int
    
    /// Initial investment amount (shares * start price)
    let initialInvestment: Double
    
    /// Current value based on capital only (shares * end price)
    let currentValueCapitalOnly: Double
    
    /// Capital gain/loss in dollars
    let capitalAppreciationDollars: Double
    
    /// Annual yield percentage from user input
    let annualYieldPercentInput: Double
    
    /// Estimated total yield income over holding period
    let totalYieldIncomeDollars: Double
    
    /// Total return before expenses (capital + yield)
    let totalReturnDollarsGross: Double
    
    /// Annualized return percentage
    let annualizedTotalReturnPct: Double
    
    /// Total expense cost over holding period
    let totalExpenseDollars: Double
    
    /// Net return after expenses
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
    
    /// Weighted average annualized return
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
        // Fallback format if NumberFormatter fails
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "$%.2f", self)
    }

    /// Formats the value as signed currency (e.g., +$1,234.56 or -$567.89)
    /// Positive values explicitly show the plus sign
    func formattedAsCurrencySigned() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.positivePrefix = formatter.plusSign // Add plus sign for positive numbers
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        // Fallback format if NumberFormatter fails
        return formatter.string(from: NSNumber(value: self)) ?? String(format: "%@%.2f", self >= 0 ? "+" : "", self)
    }
}
