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

import SwiftUI

/// Manages the business logic and state for the probability calculator
/// This class handles all probability calculations and maintains the app's state
/// Implements ObservableObject for SwiftUI data binding
class ProbabilityCalculator: ObservableObject {
    /// Array of room data that triggers UI updates when modified
    /// Automatically recalculates probabilities when room data changes
    @Published var roomData: [RoomData] {
        didSet {
            validateAndCalculate()
        }
    }
    
    /// Calculation results that update the UI when changed
    /// Contains all probability values used in the Bayesian analysis
    @Published var results: CalculationResults
    
    /// Controls the edit mode state of the view
    /// Determines whether room data can be modified
    @Published var editMode: EditMode = .inactive
    
    /// Controls the visibility of validation error alerts
    /// Shown when input data is invalid
    @Published var showValidationAlert = false
    
    /// Initializes the calculator with default room data
    /// Sets up initial room configurations and calculates initial probabilities
    init() {
        self.roomData = [
            RoomData(room: "Bedroom", noise: 15, noNoise: 135),
            RoomData(room: "Study", noise: 5, noNoise: 15)
        ]
        self.results = CalculationResults()
        calculateProbabilities()
    }
    
    /// Validates input data and triggers probability calculations
    /// Shows an alert if validation fails
    /// This method is called automatically when room data changes
    func validateAndCalculate() {
        if roomData.allSatisfy({ $0.isValid }) {
            calculateProbabilities()
            showValidationAlert = false
        } else {
            showValidationAlert = true
        }
    }
    
    /// Performs all Bayesian probability calculations based on current room data
    /// Includes checks to prevent division by zero and handle edge cases
    /// Updates the results structure with all calculated probabilities
    private func calculateProbabilities() {
        guard roomData.count >= 2 else { return }
        
        // Extract values from first room (Bedroom)
        let bedroomNoise = roomData[0].noise
        let bedroomTotal = roomData[0].total
        
        // Extract values from second room (Study)
        let studyNoise = roomData[1].noise
        let studyTotal = roomData[1].total
        
        let totalObservations = bedroomTotal + studyTotal
        guard totalObservations > 0 else { return }
        
        let totalNoise = bedroomNoise + studyNoise
        
        // Calculate Prior Probabilities
        let pB = bedroomTotal / totalObservations // P(B)
        let pS = studyTotal / totalObservations   // P(S)
        
        // Calculate Likelihoods
        let pNGivenB = bedroomTotal > 0 ? bedroomNoise / bedroomTotal : 0 // P(N|B)
        let pNGivenS = studyTotal > 0 ? studyNoise / studyTotal : 0       // P(N|S)
        
        // Calculate total probability of noise
        let pN = totalNoise / totalObservations    // P(N)
        
        // Calculate Posterior Probabilities using Bayes' Theorem
        let pBGivenN = pN > 0 ? (pNGivenB * pB) / pN : 0 // P(B|N)
        let pSGivenN = pN > 0 ? (pNGivenS * pS) / pN : 0 // P(S|N)
        
        // Update results structure with all calculated probabilities
        results = CalculationResults(
            priorB: pB,
            priorS: pS,
            likelihoodNB: pNGivenB,
            likelihoodNS: pNGivenS,
            posteriorBN: pBGivenN,
            posteriorSN: pSGivenN,
            pNDirect: pN,
            pNCalculated: (pNGivenB * pB) + (pNGivenS * pS)
        )
    }
}
