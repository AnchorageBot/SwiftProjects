//===------------------------------------------------===//
// BayesCalculator
// A SwiftUI application for Bayesian probability analysis
//===------------------------------------------------===//
// Version: 1.0
// Swift Version: 6.0
// Created: December 12, 2024
//
// Abstract:
// This application implements a Bayesian probability calculator
// specifically designed to solve the phone location problem.
// It uses Bayes' Theorem to calculate the probability of a phone's
// location (Bedroom vs Study) based on noise observations.
// The app provides an intuitive interface for data input and
// displays calculated probabilities including priors, likelihoods,
// and posteriors.
//===------------------------------------------------===//

import Foundation

/// Stores all calculated probability values for the Bayesian analysis
/// This structure serves as a container for all probability values used
/// in the phone location problem, including priors, likelihoods, and
/// posterior probabilities.
struct CalculationResults {
    /// Prior probability that phone is in Bedroom - P(B)
    /// Represents the initial probability before considering noise evidence
    var priorB: Double = 0
    
    /// Prior probability that phone is in Study - P(S)
    /// Represents the initial probability before considering noise evidence
    var priorS: Double = 0
    
    /// Likelihood of noise given Bedroom - P(N|B)
    /// Probability of observing noise when the phone is in the Bedroom
    var likelihoodNB: Double = 0
    
    /// Likelihood of noise given Study - P(N|S)
    /// Probability of observing noise when the phone is in the Study
    var likelihoodNS: Double = 0
    
    /// Posterior probability of Bedroom given noise - P(B|N)
    /// Updated probability that phone is in Bedroom after observing noise
    var posteriorBN: Double = 0
    
    /// Posterior probability of Study given noise - P(S|N)
    /// Updated probability that phone is in Study after observing noise
    var posteriorSN: Double = 0
    
    /// Direct calculation of noise probability - P(N)
    /// Probability of observing noise regardless of location
    var pNDirect: Double = 0
    
    /// Calculated probability of noise using Law of Total Probability
    /// Used to verify calculations by comparing with pNDirect
    var pNCalculated: Double = 0
}
