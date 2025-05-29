//
// ETF_v7
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
//

import Foundation

// MARK: - Portfolio Calculator
/// Handles all financial calculations for ETF analysis
/// Pure computational logic with no UI dependencies
struct PortfolioCalculator {

    // MARK: - Date Calculations
    /// Calculates the number of days between purchase and analysis dates
    func calculateDaysHeld(startDate: Date, endDate: Date) -> Int {
        // Ensure valid date range
        guard endDate >= startDate else { return 0 }
        
        // Use Calendar for accurate day calculation
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }

    // MARK: - Return Calculations
    /// Calculates annualized return using compound annual growth rate (CAGR)
    /// Formula: ((Final Value / Initial Value)^(365/Days Held)) - 1
    func calculateAnnualizedReturn(
        initialValue: Double,
        finalValue: Double,
        daysHeld: Int
    ) -> Double {
        // Validate inputs
        guard daysHeld > 0, initialValue > 0 else { return 0.0 }
        
        // Calculate total return
        let totalReturn = (finalValue - initialValue) / initialValue
        
        // Annualize using CAGR formula
        let yearsHeld = Double(daysHeld) / 365.0
        let annualizedReturn = pow(1 + totalReturn, 1 / yearsHeld) - 1
        
        // Return as percentage
        return annualizedReturn * 100
    }

    // MARK: - ETF Analysis
    /// Analyzes a single ETF and calculates all performance metrics
    func analyzeETF(etfInput: ETFInput) -> ETFAnalysisResult? {
        // Validate input
        guard etfInput.isValid else { return nil }

        // Calculate time metrics
        let daysHeld = calculateDaysHeld(
            startDate: etfInput.startDate,
            endDate: etfInput.endDate
        )
        let yearsHeld = Double(daysHeld) / 365.0

        // Calculate investment values
        let initialInvestment = etfInput.shares * etfInput.startPrice
        let currentValue = etfInput.shares * etfInput.endPrice
        let capitalAppreciation = currentValue - initialInvestment

        // Calculate yield income
        // Annual yield is based on initial investment value
        let annualYieldAmount = initialInvestment * (etfInput.annualYieldPercent / 100)
        let totalYieldIncome = annualYieldAmount * yearsHeld

        // Calculate returns
        let grossReturn = capitalAppreciation + totalYieldIncome
        let finalValue = initialInvestment + grossReturn
        
        // Calculate annualized return
        let annualizedReturn = calculateAnnualizedReturn(
            initialValue: initialInvestment,
            finalValue: finalValue,
            daysHeld: daysHeld
        )

        // Calculate expenses
        // Expense ratio is annual, so multiply by years held
        let annualExpense = initialInvestment * (etfInput.expenseRatioPercent / 100)
        let totalExpenses = annualExpense * yearsHeld

        // Calculate net return
        let netReturn = grossReturn - totalExpenses

        // Create result object
        return ETFAnalysisResult(
            name: etfInput.name,
            daysHeld: daysHeld,
            initialInvestment: initialInvestment,
            currentValueCapitalOnly: currentValue,
            capitalAppreciationDollars: capitalAppreciation,
            annualYieldPercentInput: etfInput.annualYieldPercent,
            totalYieldIncomeDollars: totalYieldIncome,
            totalReturnDollarsGross: grossReturn,
            annualizedTotalReturnPct: annualizedReturn,
            totalExpenseDollars: totalExpenses,
            netReturnDollars: netReturn
        )
    }

    // MARK: - Portfolio Analysis
    /// Analyzes the entire portfolio and calculates aggregate metrics
    func analyzePortfolio(etfResultsList: [ETFAnalysisResult]) -> PortfolioSummaryResult {
        var summary = PortfolioSummaryResult()
        
        // Return empty summary if no results
        guard !etfResultsList.isEmpty else { return summary }

        // Calculate totals
        for result in etfResultsList {
            summary.initialInvestment += result.initialInvestment
            summary.currentValueCapitalOnly += result.currentValueCapitalOnly
            summary.capitalAppreciationDollars += result.capitalAppreciationDollars
            summary.totalYieldIncomeDollars += result.totalYieldIncomeDollars
            summary.totalReturnDollarsGross += result.totalReturnDollarsGross
            summary.totalExpenseDollars += result.totalExpenseDollars
            summary.netReturnDollars += result.netReturnDollars
        }

        // Calculate weighted average annualized return
        // Weight by initial investment size
        if summary.initialInvestment > 0 {
            var weightedReturn = 0.0
            for result in etfResultsList {
                let weight = result.initialInvestment / summary.initialInvestment
                weightedReturn += result.annualizedTotalReturnPct * weight
            }
            summary.weightedAnnualizedTotalReturnPct = weightedReturn
        }

        // Calculate current allocations
        // Based on current value, not initial investment
        if summary.currentValueCapitalOnly > 0 {
            for result in etfResultsList {
                let percentage = (result.currentValueCapitalOnly / summary.currentValueCapitalOnly) * 100
                summary.allocations.append(
                    PortfolioAllocation(name: result.name, percentage: percentage)
                )
            }
        } else {
            // Edge case: all ETFs have zero value
            // Distribute equally
            let equalPercentage = 100.0 / Double(etfResultsList.count)
            for result in etfResultsList {
                summary.allocations.append(
                    PortfolioAllocation(name: result.name, percentage: equalPercentage)
                )
            }
        }
        
        return summary
    }
}
