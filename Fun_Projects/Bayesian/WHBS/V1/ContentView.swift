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


import SwiftUI

// Data model for room statistics
struct RoomData: Identifiable {
    let id = UUID()
    let room: String
    let noise: Double
    let noNoise: Double
    
    var total: Double {
        noise + noNoise
    }
}

// View model to handle calculations
class ProbabilityCalculator: ObservableObject {
    @Published var roomData: [RoomData]
    @Published var results: CalculationResults
    
    init() {
        self.roomData = [
            RoomData(room: "Bedroom", noise: 15, noNoise: 135),
            RoomData(room: "Study", noise: 5, noNoise: 15)
        ]
        self.results = CalculationResults()
        calculateProbabilities()
    }
    
    struct CalculationResults {
        var priorB: Double = 0
        var priorS: Double = 0
        var likelihoodNB: Double = 0
        var likelihoodNS: Double = 0
        var posteriorBN: Double = 0
        var posteriorSN: Double = 0
        var pNDirect: Double = 0
        var pNCalculated: Double = 0
    }
    
    func calculateProbabilities() {
        let bedroomNoise = roomData[0].noise
        let bedroomTotal = roomData[0].total
        let studyNoise = roomData[1].noise
        let studyTotal = roomData[1].total
        let totalObservations = bedroomTotal + studyTotal
        let totalNoise = bedroomNoise + studyNoise
        
        // Prior Probabilities
        let pB = bedroomTotal / totalObservations
        let pS = studyTotal / totalObservations
        
        // Likelihoods
        let pNGivenB = bedroomNoise / bedroomTotal
        let pNGivenS = studyNoise / studyTotal
        
        // Bayesian calculations
        let pN = totalNoise / totalObservations
        let pBGivenN = (pNGivenB * pB) / pN
        let pSGivenN = (pNGivenS * pS) / pN
        
        // Verification
        let pNCalculated = (pNGivenB * pB) + (pNGivenS * pS)
        
        results = CalculationResults(
            priorB: pB,
            priorS: pS,
            likelihoodNB: pNGivenB,
            likelihoodNS: pNGivenS,
            posteriorBN: pBGivenN,
            posteriorSN: pSGivenN,
            pNDirect: pN,
            pNCalculated: pNCalculated
        )
    }
}

struct ContentView: View {
    @StateObject private var calculator = ProbabilityCalculator()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Input Data")) {
                    ForEach(calculator.roomData) { room in
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
        }
    }
}

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
