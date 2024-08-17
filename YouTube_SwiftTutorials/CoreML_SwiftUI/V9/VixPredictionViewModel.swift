//
// VixRefresh
// VixPredictionViewModel.swift
//
// Created on 8/12/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/*
 Abstract:
 This file defines the VixPredictionViewModel class, which serves as the view model for the VIX predictor application. It manages the state of the input data, handles the prediction process, and provides error handling and alerts.
 
 */

import SwiftUI

class VixPredictionViewModel: ObservableObject {
    // Published properties for input data
    @Published var open = ""
    @Published var high = ""
    @Published var low = ""
    @Published var close = ""
    
    // Published properties for prediction result and alerts
    @Published var predictionResult: Double?
    @Published var alertInfo: AlertInfo?
    
    private var vixModel: VixPredictionModel?
    
    // Initialize the view model and VixPredictionModel
    init() {
        print("VixPredictionViewModel init started")
        do {
            print("Attempting to initialize VixPredictionModel...")
            self.vixModel = try VixPredictionModel()
            print("VixPredictionModel initialized successfully")
        } catch {
            print("Error initializing VixPredictionModel: \(error)")
            showAlert(title: "Initialization Error", message: "Failed to initialize VixPredictionModel: \(error.localizedDescription)")
        }
        print("VixPredictionViewModel init completed")
    }
    
    // Function to trigger VIX prediction
    func predictVix() {
        print("predictVix called")
        guard let vixModel = vixModel else {
            print("VixPredictionModel is nil")
            showAlert(title: "Error", message: "VixPredictionModel not initialized")
            return
        }
        
        // Validate input values
        guard let openValue = Double(open),
              let highValue = Double(high),
              let lowValue = Double(low),
              let closeValue = Double(close) else {
            print("Invalid input values")
            showAlert(title: "Invalid Input", message: "Please enter valid numeric values for Open, High, Low, and Close.")
            return
        }
        
        print("Input values: Open: \(openValue), High: \(highValue), Low: \(lowValue), Close: \(closeValue)")
        
        // Perform prediction
        do {
            let prediction = try vixModel.predict(
                open: openValue,
                high: highValue,
                low: lowValue,
                close: closeValue
            )
            print("Prediction result: \(prediction)")
            predictionResult = prediction
        } catch {
            print("Error in predictVix: \(error)")
            showAlert(title: "Prediction Error", message: error.localizedDescription)
        }
    }
    
    // Helper function to show alerts
    private func showAlert(title: String, message: String) {
        print("Showing alert: \(title) - \(message)")
        alertInfo = AlertInfo(title: title, message: message)
    }
}

// Structure to represent alert information
struct AlertInfo: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}
