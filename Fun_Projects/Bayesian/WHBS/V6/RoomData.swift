//
// BayesCalculator
// RoomData.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import Foundation

/// Represents a room with associated noise observation data
/// Implements Identifiable for SwiftUI list rendering and Equatable for state comparison
struct RoomData: Identifiable, Equatable {
    /// Unique identifier for the room
    let id = UUID()
    /// Name of the room (e.g., "Bedroom", "Study")
    var room: String
    /// Number of times noise was observed in this room
    /// Automatically prevents negative values
    var noise: Double {
        didSet {
            if noise < 0 { noise = 0 }
        }
    }
    /// Number of times no noise was observed in this room
    /// Automatically prevents negative values
    var noNoise: Double {
        didSet {
            if noNoise < 0 { noNoise = 0 }
        }
    }
    
    /// Calculates the total number of observations for this room
    var total: Double {
        noise + noNoise
    }
    
    /// Validates that all room data values are acceptable
    var isValid: Bool {
        noise >= 0 && noNoise >= 0 && !room.isEmpty
    }
    
    /// Implements Equatable to compare room data instances
    static func == (lhs: RoomData, rhs: RoomData) -> Bool {
        lhs.id == rhs.id && lhs.room == rhs.room &&
        lhs.noise == rhs.noise && lhs.noNoise == rhs.noNoise
    }
}
