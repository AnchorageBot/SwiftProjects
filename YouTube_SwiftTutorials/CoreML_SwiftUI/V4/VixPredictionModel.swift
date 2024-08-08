//
// VixData
// VixPredictionModel.swift
//
// Created on 8/5/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

import Foundation
import CoreML

/// A struct that encapsulates the VIX prediction model and provides a method to make predictions.
struct VixPredictionModel {
    /// The Core ML model used for VIX predictions.
    private let model: Vix2407Auto
    
    /// A date formatter to convert Date objects to strings in the format expected by the model.
    private let dateFormatter: DateFormatter
    
    /// Initializes a new VixPredictionModel.
    /// - Throws: An error if the Core ML model cannot be loaded.
    init() throws {
        let config = MLModelConfiguration()
        self.model = try Vix2407Auto(configuration: config)
        
        // Initialize the date formatter
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust this format to match your model's expected input
        
        // Print model description for debugging
        print("Model description: \(model.model.description)")
    }
    
    /// Predicts the VIX value based on the given inputs.
    /// - Parameters:
    ///   - date: The date for the prediction.
    ///   - open: The opening value.
    ///   - high: The highest value.
    ///   - low: The lowest value.
    ///   - close: The closing value.
    /// - Returns: The predicted VIX value.
    /// - Throws: An error if the prediction fails.
    func predict(date: Date, open: Double, high: Double, low: Double, close: Double) throws -> Double {
        let dateString = dateFormatter.string(from: date)
        
        let input = Vix2407AutoInput(
            Date: dateString,
            Open: open,
            High: high,
            Low: low,
            Close: close
        )
        
        do {
            let prediction = try model.prediction(input: input)
            return prediction.EstVix
        } catch {
            print("Full error: \(error)")
            print("Model description: \(model.model.description)")
            throw error
        }
    }
}
