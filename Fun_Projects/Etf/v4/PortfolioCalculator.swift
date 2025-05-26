//
// ETF_v3
// PortfolioCalculator.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
// Refactored by Claude (Anthropic) on 5/23/25
//

import Foundation

// MARK: - Portfolio Calculator
/// Handles all financial calculations for ETF analysis
/// This is a pure computational struct with no UI dependencies
struct PortfolioCalculator {

    // MARK: - Date Calculations
    /// Calculates the number of days between two dates
    /// - Parameters:
    ///   - startDate: The purchase date
    ///   - endDate: The analysis date
    /// - Returns: Number of days between dates, or 0 if endDate is before startDate
    func calculateDaysHeld(startDate: Date, endDate: Date) -> Int {
        // Ensure end date is not before start date
        if endDate < startDate { return 0 }
        
        // Use Calendar to calculate date difference
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }

    // MARK: - Return Calculations
    /// Calculates annualized return percentage from total return
    /// Uses compound annual growth rate (CAGR) formula
    /// - Parameters:
    ///   - initialValue: Starting investment amount
    ///   - finalValueGross: Ending value including all gains
    ///   - daysHeld: Number of days investment was held
    /// - Returns: Annualized return as a percentage (e.g., 10.5 for 10.5%)
    func calculateAnnualizedReturnFromTotals(initialValue: Double, finalValueGross: Double, daysHeld: Int) -> Double {
        // Guard against invalid inputs
        if daysHeld <= 0 || initialValue <= 0 {
            return 0.0
        }
        
        // Calculate simple total return
        let simpleTotalReturn = (finalValueGross - initialValue) / initialValue
        
        // Annualize the return using CAGR formula
        // Formula: ((1 + total return)^(365/days held)) - 1
        let annualizedReturn = pow((1 + simpleTotalReturn), (365.0 / Double(daysHeld))) - 1
        
        // Convert to percentage
        return annualizedReturn * 100
    }

    // MARK: - ETF Analysis
    /// Analyzes a single ETF investment and calculates all metrics
    /// - Parameter etfInput: The ETF input data
    /// - Returns: Analysis results or nil if input is invalid
    func analyzeETF(etfInput: ETFInput) -> ETFAnalysisResult? {
        // Validate and unwrap all required input values
        guard etfInput.isValid,
              let expenseRatioPercent = etfInput.expenseRatioPercent,
              let annualYieldPercent = etfInput.annualYieldPercent,
              let shares = etfInput.shares,
              let startPrice = etfInput.startPrice,
              let endPrice = etfInput.endPrice else {
            return nil
        }

        // MARK: Time Calculations
        let daysHeld = calculateDaysHeld(startDate: etfInput.startDate, endDate: etfInput.endDate)
        let yearsHeld = daysHeld > 0 ? Double(daysHeld) / 365.0 : 0.0

        // MARK: Investment Value Calculations
        let initialInvestment = shares * startPrice
        let currentValue = shares * endPrice

        // MARK: Capital Appreciation
        let capitalAppreciationDollars = currentValue - initialInvestment

        // MARK: Yield Income Calculations
        // Convert percentage to decimal (5% = 0.05)
        let yieldDecimal = annualYieldPercent / 100.0
        // Calculate annual yield based on initial investment
        let estimatedAnnualYieldOnInitial = initialInvestment * yieldDecimal
        // Total yield over holding period
        let totalYieldIncomeDollars = estimatedAnnualYieldOnInitial * yearsHeld

        // MARK: Total Return (Gross)
        let totalReturnDollarsGross = capitalAppreciationDollars + totalYieldIncomeDollars

        // MARK: Annualized Return
        // Calculate final value for annualization (initial + all gains)
        let finalValueForAnnualization = initialInvestment + totalReturnDollarsGross
        let annualizedTotalReturnPct = calculateAnnualizedReturnFromTotals(
            initialValue: initialInvestment,
            finalValueGross: finalValueForAnnualization,
            daysHeld: daysHeld
        )

        // MARK: Expense Calculations
        // Convert expense ratio to decimal (0.03% = 0.0003)
        let expenseRatioDecimal = expenseRatioPercent / 100.0
        // Total expenses based on initial investment over holding period
        let totalExpenseDollars = initialInvestment * expenseRatioDecimal * yearsHeld

        // MARK: Net Return
        let netReturnDollars = totalReturnDollarsGross - totalExpenseDollars

        // Create and return the result object
        return ETFAnalysisResult(
            name: etfInput.name,
            daysHeld: daysHeld,
            initialInvestment: initialInvestment,
            currentValueCapitalOnly: currentValue,
            capitalAppreciationDollars: capitalAppreciationDollars,
            annualYieldPercentInput: annualYieldPercent,
            totalYieldIncomeDollars: totalYieldIncomeDollars,
            totalReturnDollarsGross: totalReturnDollarsGross,
            annualizedTotalReturnPct: annualizedTotalReturnPct,
            totalExpenseDollars: totalExpenseDollars,
            netReturnDollars: netReturnDollars
        )
    }

    // MARK: - Portfolio Analysis
    /// Analyzes the entire portfolio and calculates aggregate metrics
    /// - Parameter etfResultsList: Array of individual ETF analysis results
    /// - Returns: Portfolio summary with totals and weighted averages
    func analyzePortfolio(etfResultsList: [ETFAnalysisResult]) -> PortfolioSummaryResult {
        // Initialize empty summary
        var summary = PortfolioSummaryResult()

        // Return empty summary if no ETFs
        guard !etfResultsList.isEmpty else { return summary }

        // MARK: Calculate Totals
        // Sum up all individual ETF metrics
        for res in etfResultsList {
            summary.initialInvestment += res.initialInvestment
            summary.currentValueCapitalOnly += res.currentValueCapitalOnly
            summary.capitalAppreciationDollars += res.capitalAppreciationDollars
            summary.totalYieldIncomeDollars += res.totalYieldIncomeDollars
            summary.totalReturnDollarsGross += res.totalReturnDollarsGross
            summary.totalExpenseDollars += res.totalExpenseDollars
            summary.netReturnDollars += res.netReturnDollars
        }

        // MARK: Calculate Weighted Average Return
        // Weight each ETF's return by its initial investment size
        if summary.initialInvestment > 0 {
            for res in etfResultsList {
                let weight = res.initialInvestment / summary.initialInvestment
                summary.weightedAnnualizedTotalReturnPct += res.annualizedTotalReturnPct * weight
            }
        }

        // MARK: Calculate Portfolio Allocations
        // Based on current value (not initial investment)
        if summary.currentValueCapitalOnly > 0 {
            for res in etfResultsList {
                let percentage = (res.currentValueCapitalOnly / summary.currentValueCapitalOnly) * 100
                summary.allocations.append(PortfolioAllocation(name: res.name, percentage: percentage))
            }
        } else if !etfResultsList.isEmpty {
            // Handle edge case where all ETFs have zero current value
            // Distribute equally among all ETFs
            let defaultPercentage = 100.0 / Double(etfResultsList.count)
            for res in etfResultsList {
                summary.allocations.append(PortfolioAllocation(name: res.name, percentage: defaultPercentage))
            }
        }
        
        return summary
    }
}
