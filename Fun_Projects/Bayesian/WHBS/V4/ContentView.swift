//
// BayesCalculator
// ContentView.swift
//
// Created on 12/12/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

// To do:
// Visualization of probabilities using charts
// Saving different scenarios
// Any other enhancements you'd like to add

// Abstract:
// This SwiftUI application implements a Bayesian probability calculator that analyzes the likelihood
// of a phone's location based on noise occurrence. It demonstrates the practical application of
// Bayes' Theorem through an interactive interface that allows users to input and edit room data,
// visualize probabilities, and save different scenarios. The app follows the MVVM (Model-View-ViewModel)
// architectural pattern and implements real-time input validation.

import SwiftUI

// MARK: - Data Models

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

// MARK: - View Model

/// Manages the business logic and state for the probability calculator
/// Implements ObservableObject for SwiftUI data binding
class ProbabilityCalculator: ObservableObject {
    /// Array of room data that triggers UI updates when modified
    @Published var roomData: [RoomData] {
        didSet {
            validateAndCalculate()
        }
    }
    /// Calculation results that update the UI when changed
    @Published var results: CalculationResults
    /// Controls the edit mode state of the view
    @Published var editMode: EditMode = .inactive
    /// Controls the visibility of validation error alerts
    @Published var showValidationAlert = false
    
    /// Initializes the calculator with default room data
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

// MARK: - Views

/// View component for displaying and editing room data
struct RoomDataView: View {
    /// Binding to the room data being displayed/edited
    @Binding var roomData: RoomData
    /// Controls whether the view is in edit mode
    let isEditing: Bool
    
    var body: some View {
        VStack {
            if isEditing {
                // Editable fields shown in edit mode
                TextField("Room Name", text: $roomData.room)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("Noise:")
                    TextField("Noise", value: $roomData.noise, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    Text("No Noise:")
                    TextField("No Noise", value: $roomData.noNoise, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
            } else {
                // Display-only view when not in edit mode
                VStack(alignment: .leading) {
                    Text(roomData.room)
                        .font(.headline)
                    HStack {
                        Text("Noise: \(Int(roomData.noise))")
                        Spacer()
                        Text("No Noise: \(Int(roomData.noNoise))")
                    }
                    .font(.subheadline)
                }
            }
        }
    }
}

/// Reusable view for displaying a probability value with its label
struct ProbabilityRow: View {
    /// Label describing the probability being displayed
    let label: String
    /// Probability value to display (0-1 range)
    let value: Double
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(String(format: "%.2f%%", value * 100))
        }
    }
}

/// Main view of the application
struct ContentView: View {
    /// View model instance that manages the app's state and logic
    @StateObject private var calculator = ProbabilityCalculator()
    
    var body: some View {
        NavigationView {
            List {
                // MARK: Input Section
                Section(header: Text("Input Data")) {
                    ForEach($calculator.roomData) { $room in
                        RoomDataView(roomData: $room, isEditing: calculator.editMode == .active)
                    }
                }
                
                // MARK: Results Sections
                Section(header: Text("Prior Probabilities")) {
                    ProbabilityRow(label: "P(B) Bedroom", value: calculator.results.priorB)
                    ProbabilityRow(label: "P(S) Study", value: calculator.results.priorS)
                }
                
                Section(header: Text("Likelihoods")) {
                    ProbabilityRow(label: "P(N|B) Noise given Bedroom", value: calculator.results.likelihoodNB)
                    ProbabilityRow(label: "P(N|S) Noise given Study", value: calculator.results.likelihoodNS)
                }
                
                Section(header: Text("Posterior Probabilities")) {
                    ProbabilityRow(label: "P(B|N) Bedroom given Noise", value: calculator.results.posteriorBN)
                    ProbabilityRow(label: "P(S|N) Study given Noise", value: calculator.results.posteriorSN)
                }
                
                Section(header: Text("Verification")) {
                    ProbabilityRow(label: "P(N) Direct", value: calculator.results.pNDirect)
                    ProbabilityRow(label: "P(N) Calculated", value: calculator.results.pNCalculated)
                }
            }
            .navigationTitle("Probability Calculator")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $calculator.editMode)
            .alert("Invalid Input", isPresented: $calculator.showValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please ensure all values are valid numbers greater than or equal to 0.")
            }
        }
    }
}

/// SwiftUI preview provider
#Preview {
    ContentView()
}
