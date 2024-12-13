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
//Visualization of probabilities using charts
//Saving different scenarios
//Any other enhancements you'd like to add

// Abstract:
// This SwiftUI application implements a Bayesian probability calculator that analyzes the likelihood
// of a phone's location based on noise occurrence. It demonstrates the practical application of
// Bayes' Theorem through an interactive interface that allows users to input and edit room data,
// visualize probabilities, and save different scenarios. The app follows the MVVM (Model-View-ViewModel)
// architectural pattern and implements real-time input validation.

import SwiftUI

// MARK: - Data Models

/// Represents the data structure for room statistics with built-in validation
struct RoomData: Identifiable {
    let id = UUID()
    var room: String
    // Noise value with validation to prevent negative numbers
    var noise: Double {
        didSet {
            if noise < 0 { noise = 0 }
        }
    }
    // No-noise value with validation to prevent negative numbers
    var noNoise: Double {
        didSet {
            if noNoise < 0 { noNoise = 0 }
        }
    }
    
    /// Calculates the total observations for this room
    var total: Double {
        noise + noNoise
    }
    
    /// Validates that all room data values are acceptable
    var isValid: Bool {
        noise >= 0 && noNoise >= 0 && !room.isEmpty
    }
}

/// Holds the results of all probability calculations
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
class ProbabilityCalculator: ObservableObject {
    // MARK: Published Properties
    
    /// Array of room data that triggers UI updates when modified
    @Published var roomData: [RoomData]
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
    func validateAndCalculate() {
        if roomData.allSatisfy({ $0.isValid }) {
            calculateProbabilities()
            showValidationAlert = false
        } else {
            showValidationAlert = true
        }
    }
    
    /// Calculates all probabilities based on current room data
    private func calculateProbabilities() {
        // Extract values from first room (Bedroom)
        let bedroomNoise = roomData[0].noise
        let bedroomTotal = roomData[0].total
        
        // Extract values from second room (Study)
        let studyNoise = roomData[1].noise
        let studyTotal = roomData[1].total
        
        // Calculate totals
        let totalObservations = bedroomTotal + studyTotal
        let totalNoise = bedroomNoise + studyNoise
        
        // Calculate Prior Probabilities
        let pB = bedroomTotal / totalObservations // P(B)
        let pS = studyTotal / totalObservations   // P(S)
        
        // Calculate Likelihoods
        let pNGivenB = bedroomNoise / bedroomTotal // P(N|B)
        let pNGivenS = studyNoise / studyTotal     // P(N|S)
        
        // Calculate total probability of noise
        let pN = totalNoise / totalObservations    // P(N)
        
        // Calculate Posterior Probabilities using Bayes' Theorem
        let pBGivenN = (pNGivenB * pB) / pN       // P(B|N)
        let pSGivenN = (pNGivenS * pS) / pN       // P(S|N)
        
        // Update results
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
                        VStack {
                            if calculator.editMode == .active {
                                // Editable fields shown in edit mode
                                TextField("Room Name", text: $room.room)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                HStack {
                                    Text("Noise:")
                                    TextField("Noise", value: $room.noise, format: .number)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                    
                                    Text("No Noise:")
                                    TextField("No Noise", value: $room.noNoise, format: .number)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                }
                            } else {
                                // Display-only view when not in edit mode
                                VStack(alignment: .leading) {
                                    Text(room.room)
                                        .font(.headline)
                                    HStack {
                                        Text("Noise: \(Int(room.noise))")
                                        Spacer()
                                        Text("No Noise: \(Int(room.noNoise))")
                                    }
                                    .font(.subheadline)
                                }
                            }
                        }
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
            .onChange(of: calculator.roomData) { _ in
                calculator.validateAndCalculate()
            }
        }
    }
}

/// Reusable view for displaying a probability value with its label
struct ProbabilityRow: View {
    let label: String
    let value: Double
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(String(format: "%.2f%%", value * 100))
        }
    }
}


#Preview {
    ContentView()
}
