//
// ETF_v2
// PortfolioCalculator.swift
//
// Created on 5/21/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Google Gemini Advanced 2.5 Pro
//

import Foundation

struct PortfolioCalculator {

    func calculateDaysHeld(startDate: Date, endDate: Date) -> Int {
        if endDate < startDate { return 0 }
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }

    func calculateAnnualizedReturnFromTotals(initialValue: Double, finalValueGross: Double, daysHeld: Int) -> Double {
        if daysHeld <= 0 || initialValue <= 0 {
            return 0.0
        }
        let simpleTotalReturn = (finalValueGross - initialValue) / initialValue
        let annualizedReturn = pow((1 + simpleTotalReturn), (365.0 / Double(daysHeld))) - 1
        return annualizedReturn * 100
    }

    func analyzeETF(etfInput: ETFInput) -> ETFAnalysisResult? {
        guard etfInput.isValid,
              let expenseRatioPercent = etfInput.expenseRatioPercent,
              let annualYieldPercent = etfInput.annualYieldPercent,
              let shares = etfInput.shares,
              let startPrice = etfInput.startPrice,
              let endPrice = etfInput.endPrice else {
            return nil // Should not happen if isValid is checked
        }

        let daysHeld = calculateDaysHeld(startDate: etfInput.startDate, endDate: etfInput.endDate)
        let yearsHeld = daysHeld > 0 ? Double(daysHeld) / 365.0 : 0.0

        let initialInvestment = shares * startPrice
        let currentValue = shares * endPrice

        let capitalAppreciationDollars = currentValue - initialInvestment

        let yieldDecimal = annualYieldPercent / 100.0
        let estimatedAnnualYieldOnInitial = initialInvestment * yieldDecimal
        let totalYieldIncomeDollars = estimatedAnnualYieldOnInitial * yearsHeld

        let totalReturnDollarsGross = capitalAppreciationDollars + totalYieldIncomeDollars

        let finalValueForAnnualization = initialInvestment + totalReturnDollarsGross
        let annualizedTotalReturnPct = calculateAnnualizedReturnFromTotals(
            initialValue: initialInvestment,
            finalValueGross: finalValueForAnnualization,
            daysHeld: daysHeld
        )

        let expenseRatioDecimal = expenseRatioPercent / 100.0
        let totalExpenseDollars = initialInvestment * expenseRatioDecimal * yearsHeld

        let netReturnDollars = totalReturnDollarsGross - totalExpenseDollars

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

    func analyzePortfolio(etfResultsList: [ETFAnalysisResult]) -> PortfolioSummaryResult {
        var summary = PortfolioSummaryResult()

        guard !etfResultsList.isEmpty else { return summary }

        for res in etfResultsList {
            summary.initialInvestment += res.initialInvestment
            summary.currentValueCapitalOnly += res.currentValueCapitalOnly
            summary.capitalAppreciationDollars += res.capitalAppreciationDollars
            summary.totalYieldIncomeDollars += res.totalYieldIncomeDollars
            summary.totalReturnDollarsGross += res.totalReturnDollarsGross
            summary.totalExpenseDollars += res.totalExpenseDollars
            summary.netReturnDollars += res.netReturnDollars
        }

        if summary.initialInvestment > 0 {
            for res in etfResultsList {
                let weight = res.initialInvestment / summary.initialInvestment
                summary.weightedAnnualizedTotalReturnPct += res.annualizedTotalReturnPct * weight
            }
        }

        if summary.currentValueCapitalOnly > 0 {
            for res in etfResultsList {
                let percentage = (res.currentValueCapitalOnly / summary.currentValueCapitalOnly) * 100
                summary.allocations.append(PortfolioAllocation(name: res.name, percentage: percentage))
            }
        } else if !etfResultsList.isEmpty { // Handle zero current value for allocations
            let defaultPercentage = 100.0 / Double(etfResultsList.count)
            for res in etfResultsList {
                summary.allocations.append(PortfolioAllocation(name: res.name, percentage: defaultPercentage))
            }
        }
        return summary
    }
}

