//
// BayesCalculator
// CalculationResults.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import Foundation

/// Stores all calculated probability values for the Bayesian analysis
struct CalculationResults {
    /// Prior probability that phone is in Bedroom P(B)
    var priorB: Double = 0
    /// Prior probability that phone is in Study P(S)
    var priorS: Double = 0
    /// Likelihood of noise given Bedroom P(N|B)
    var likelihoodNB: Double = 0
    /// Likelihood of noise given Study P(N|S)
    var likelihoodNS: Double = 0
    /// Posterior probability of Bedroom given noise P(B|N)
    var posteriorBN: Double = 0
    /// Posterior probability of Study given noise P(S|N)
    var posteriorSN: Double = 0
    /// Direct calculation of noise probability P(N)
    var pNDirect: Double = 0
    /// Calculated probability of noise using Law of Total Probability
    var pNCalculated: Double = 0
}
