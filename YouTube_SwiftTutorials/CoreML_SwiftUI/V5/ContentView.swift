//
// VixRefresh
// ContentView.swift
//
// Created on 8/11/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import CoreML
import SwiftUI

/// The main view of the VIX Predictor app.
struct ContentView: View {
    // MARK: - State Properties
    @State private var date = Date()
    @State private var open = ""
    @State private var high = ""
    @State private var low = ""
    @State private var close = ""
    
    @State private var predictionResult = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    // MARK: - Private Properties
    private let vixModel: VixPredictionModel
    
    // MARK: - Initialization
    init() {
        do {
            self.vixModel = try VixPredictionModel()
        } catch {
            fatalError("Failed to initialize VixPredictionModel: \(error)")
        }
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Data")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    TextField("Open", text: $open)
                        .keyboardType(.decimalPad)
                    TextField("High", text: $high)
                        .keyboardType(.decimalPad)
                    TextField("Low", text: $low)
                        .keyboardType(.decimalPad)
                    TextField("Close", text: $close)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button("Predict VIX") {
                        calcVix()
                    }
                }
                
                if !predictionResult.isEmpty {
                    Section(header: Text("Prediction")) {
                        Text(predictionResult)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("VIX Predictor")
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Calculates the VIX prediction based on user input.
    private func calcVix() {
        guard let openValue = Double(open),
              let highValue = Double(high),
              let lowValue = Double(low),
              let closeValue = Double(close) else {
            showAlert(title: "Invalid Input", message: "Please enter valid numeric values for Open, High, Low, and Close.")
            return
        }
        
        do {
            let prediction = try vixModel.predict(
                date: date,
                open: openValue,
                high: highValue,
                low: lowValue,
                close: closeValue
            )
            
            predictionResult = String(format: "Predicted VIX: %.2f", prediction)
        } catch {
            showAlert(title: "Error", message: "Sorry, there was a problem calculating a VIX estimate: \(error.localizedDescription)")
        }
    }
    
    /// Shows an alert with the given title and message.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
