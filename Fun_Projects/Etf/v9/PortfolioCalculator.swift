//
// ETF_v9
// PortfolioCalculator.swift
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

/// A struct that encapsulates all the financial calculation logic for the portfolio.
struct PortfolioCalculator {

    // MARK: - Single ETF Analysis
    /// Analyzes one ETF based on user input and returns a detailed result object.
    /// - Parameter etfInput: The `ETFInput` struct containing all user-provided data.
    /// - Returns: An `ETFAnalysisResult` optional, which is `nil` if the input is invalid.
    func analyzeETF(etfInput: ETFInput) -> ETFAnalysisResult? {
        // Step 1: Ensure the input data is valid before performing calculations.
        guard etfInput.isValid else { return nil }

        // Step 2: Calculate the holding period in days and years.
        let daysHeld = Calendar.current.dateComponents([.day], from: etfInput.startDate, to: etfInput.endDate).day ?? 0
        let yearsHeld = Double(daysHeld) / 365.0

        // Step 3: Calculate the core investment values.
        let initialInvestment = etfInput.shares * etfInput.startPrice
        let currentValue = etfInput.shares * etfInput.endPrice
        let capitalAppreciation = currentValue - initialInvestment

        // Step 4: Calculate income from dividends/yield.
        let annualYieldAmount = initialInvestment * (etfInput.annualYieldPercent / 100.0)
        let totalYieldIncome = annualYieldAmount * yearsHeld

        // Step 5: Calculate gross return and the final value for the CAGR formula.
        let grossReturn = capitalAppreciation + totalYieldIncome
        let finalValueForCAGR = initialInvestment + grossReturn
        
        // Step 6: Calculate the annualized return (Compound Annual Growth Rate).
        let annualizedReturnPct = calculateAnnualizedReturn(
            initialValue: initialInvestment,
            finalValue: finalValueForCAGR,
            daysHeld: daysHeld
        )

        // Step 7: Calculate the total cost of expenses over the holding period.
        let annualExpenseCost = initialInvestment * (etfInput.expenseRatioPercent / 100.0)
        let totalExpenses = annualExpenseCost * yearsHeld

        // Step 8: Calculate the final net return after subtracting expenses.
        let netReturn = grossReturn - totalExpenses

        // Step 9: Assemble and return the final results object.
        return ETFAnalysisResult(
            name: etfInput.name,
            daysHeld: daysHeld,
            initialInvestment: initialInvestment,
            currentValueCapitalOnly: currentValue,
            capitalAppreciationDollars: capitalAppreciation,
            annualYieldPercentInput: etfInput.annualYieldPercent,
            totalYieldIncomeDollars: totalYieldIncome,
            totalReturnDollarsGross: grossReturn,
            annualizedTotalReturnPct: annualizedReturnPct,
            totalExpenseDollars: totalExpenses,
            netReturnDollars: netReturn
        )
    }

    // MARK: - Full Portfolio Analysis
    /// Aggregates results from all ETFs to create a portfolio-wide summary.
    /// - Parameter etfResultsList: An array of `ETFAnalysisResult` objects.
    /// - Returns: A `PortfolioSummaryResult` object with aggregated data.
    func analyzePortfolio(etfResultsList: [ETFAnalysisResult]) -> PortfolioSummaryResult {
        var summary = PortfolioSummaryResult()
        
        // Return an empty summary if there are no results to process.
        guard !etfResultsList.isEmpty else { return summary }

        // Step 1: Sum up all the key metrics from individual ETF results.
        for result in etfResultsList {
            summary.initialInvestment += result.initialInvestment
            summary.currentValueCapitalOnly += result.currentValueCapitalOnly
            summary.capitalAppreciationDollars += result.capitalAppreciationDollars
            summary.totalYieldIncomeDollars += result.totalYieldIncomeDollars
            summary.totalReturnDollarsGross += result.totalReturnDollarsGross
            summary.totalExpenseDollars += result.totalExpenseDollars
            summary.netReturnDollars += result.netReturnDollars
        }

        // Step 2: Calculate the weighted average annualized return.
        // Each ETF's return is weighted by its proportion of the total initial investment.
        if summary.initialInvestment > 0 {
            var weightedReturnContribution: Double = 0.0
            for result in etfResultsList {
                let weight = result.initialInvestment / summary.initialInvestment
                weightedReturnContribution += result.annualizedTotalReturnPct * weight
            }
            summary.weightedAnnualizedTotalReturnPct = weightedReturnContribution
        }

        // Step 3: Calculate the current allocation of each ETF.
        // This is based on the *current value* of each ETF, not the initial investment.
        if summary.currentValueCapitalOnly > 0 {
            summary.allocations = etfResultsList.map { result in
                let percentage = (result.currentValueCapitalOnly / summary.currentValueCapitalOnly) * 100
                return PortfolioAllocation(name: result.name, percentage: percentage)
            }
        }
        
        return summary
    }
    
    // MARK: - Helper Calculation
    /// Calculates the Compound Annual Growth Rate (CAGR).
    /// Formula: `((Final Value / Initial Value) ^ (1 / Years)) - 1`
    private func calculateAnnualizedReturn(initialValue: Double, finalValue: Double, daysHeld: Int) -> Double {
        // CAGR is undefined if the holding period is zero or initial value is zero.
        guard daysHeld > 0, initialValue > 0 else { return 0.0 }
        
        let yearsHeld = Double(daysHeld) / 365.0
        let totalReturnRatio = finalValue / initialValue
        
        // Use the pow() function for exponentiation.
        let annualizedReturn = pow(totalReturnRatio, 1.0 / yearsHeld) - 1.0
        
        // Return the result as a percentage.
        return annualizedReturn * 100.0
    }
}
