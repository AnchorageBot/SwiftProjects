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

/// Represents a room with associated noise observation data
/// This structure maintains the state for a single room's observations,
/// including counts of noise and no-noise events. It implements
/// Identifiable for SwiftUI list rendering and Equatable for state comparison.
struct RoomData: Identifiable, Equatable {
    /// Unique identifier for the room
    /// Used by SwiftUI for list differentiation
    let id = UUID()
    
    /// Name of the room (e.g., "Bedroom", "Study")
    /// Identifies which room this data represents
    var room: String
    
    /// Number of times noise was observed in this room
    /// Property observer prevents negative values
    var noise: Double {
        didSet {
            if noise < 0 { noise = 0 }
        }
    }
    
    /// Number of times no noise was observed in this room
    /// Property observer prevents negative values
    var noNoise: Double {
        didSet {
            if noNoise < 0 { noNoise = 0 }
        }
    }
    
    /// Calculates the total number of observations for this room
    /// Returns the sum of noise and no-noise observations
    var total: Double {
        noise + noNoise
    }
    
    /// Validates that all room data values are acceptable
    /// Checks for non-negative values and non-empty room name
    var isValid: Bool {
        noise >= 0 && noNoise >= 0 && !room.isEmpty
    }
    
    /// Implements Equatable to compare room data instances
    /// Two rooms are equal if they have the same id, name, and observation counts
    static func == (lhs: RoomData, rhs: RoomData) -> Bool {
        lhs.id == rhs.id && 
        lhs.room == rhs.room &&
        lhs.noise == rhs.noise && 
        lhs.noNoise == rhs.noNoise
    }
}
