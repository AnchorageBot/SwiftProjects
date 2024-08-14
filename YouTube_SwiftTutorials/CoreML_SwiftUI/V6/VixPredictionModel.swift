//
// VixRefresh
// VixPredictionModel.swift
//
// Created on 8/11/24
// Swift Version 5.0
//
// ATS Project
// Tutor: Anthropic's AI Claude
//

/*
 
 Abstract:
 This file defines the VixPredictionModel struct, which encapsulates the Core ML model for VIX prediction. It handles model initialization and provides a method to make predictions based on input data.
 
 */

import Foundation
import CoreML

// Custom error types for VIX prediction
enum VixPredictionError: Error {
    case modelInitializationFailed(String)
    case predictionFailed(String)
    case invalidInput(String)
}

struct VixPredictionModel {
    private let model: Vix2407Auto
    private let dateFormatter: DateFormatter
    
    // Initialize the model and date formatter
    init() throws {
        print("VixPredictionModel init started")
        let config = MLModelConfiguration()
        do {
            print("Attempting to initialize Vix2407Auto...")
            self.model = try Vix2407Auto(configuration: config)
            print("Vix2407Auto initialized successfully")
            print("Model description: \(self.model.model.description)")
        } catch {
            print("Failed to initialize Vix2407Auto: \(error)")
            throw VixPredictionError.modelInitializationFailed("Failed to initialize Vix2407Auto: \(error.localizedDescription)")
        }
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        print("VixPredictionModel init completed")
    }
    
    // Make a VIX prediction based on input data
    func predict(date: Date, open: Double, high: Double, low: Double, close: Double) throws -> Double {
        print("predict function called")
        let dateString = dateFormatter.string(from: date)
        
        print("Input values: Date: \(dateString), Open: \(open), High: \(high), Low: \(low), Close: \(close)")
        
        let input = Vix2407AutoInput(Date: dateString, Open: open, High: high, Low: low, Close: close)
        
        do {
            print("Attempting prediction...")
            let output = try model.prediction(input: input)
            
            print("Prediction succeeded")
            print("Available output features: \(output.featureNames)")
            
            for featureName in output.featureNames {
                if let value = output.featureValue(for: featureName) {
                    print("Feature: \(featureName), Value: \(value)")
                }
            }
            
            if output.featureNames.contains("EstVix") {
                let result = output.EstVix
                print("Returning EstVix value: \(result)")
                return result
            } else {
                print("EstVix not found in output features")
                throw VixPredictionError.predictionFailed("EstVix not found in model output. Available features: \(output.featureNames)")
            }
        } catch {
            print("Prediction failed: \(error)")
            throw VixPredictionError.predictionFailed("Prediction failed: \(error.localizedDescription)")
        }
    }
}
