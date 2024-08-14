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

/*
 
 Abstract:
 This file defines the main user interface for the VIX predictor application. It includes input fields for date and price data, a button to trigger predictions, and a section to display the prediction result.
 
 */

import SwiftUI

struct ContentView: View {
    // StateObject to manage the view model
    @StateObject private var viewModel = VixPredictionViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                // Input section for user to enter date and price data
                Section(header: Text("Input Data")) {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                    TextField("Open", text: $viewModel.open)
                        .keyboardType(.decimalPad)
                    TextField("High", text: $viewModel.high)
                        .keyboardType(.decimalPad)
                    TextField("Low", text: $viewModel.low)
                        .keyboardType(.decimalPad)
                    TextField("Close", text: $viewModel.close)
                        .keyboardType(.decimalPad)
                }
                
                // Button to trigger VIX prediction
                Section {
                    Button("Predict VIX") {
                        viewModel.predictVix()
                    }
                }
                
                // Display prediction result if available
                if let prediction = viewModel.predictionResult {
                    Section(header: Text("Prediction")) {
                        Text("Predicted VIX: \(prediction, specifier: "%.2f")")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("VIX Predictor")
            // Alert to display any errors or information
            .alert(item: $viewModel.alertInfo) { alertInfo in
                Alert(title: Text(alertInfo.title), message: Text(alertInfo.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}
