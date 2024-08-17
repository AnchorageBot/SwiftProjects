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
    private let model: MLModel
    private let dateFormatter: DateFormatter
    
    // Initialize the model and date formatter
    init() throws {
        print("VixPredictionModel init started")
        let config = MLModelConfiguration()
        do {
            print("Attempting to initialize VixPredictorV1...")
            guard let modelURL = Bundle.main.url(forResource: "VixPredictorV1", withExtension: "mlmodelc") else {
                throw VixPredictionError.modelInitializationFailed("VixPredictorV1.mlmodelc not found in bundle")
            }
            self.model = try MLModel(contentsOf: modelURL, configuration: config)
            print("VixPredictorV1 initialized successfully")
            print("Model description: \(self.model.description)")
        } catch {
            print("Failed to initialize VixPredictorV1: \(error)")
            throw VixPredictionError.modelInitializationFailed("Failed to initialize VixPredictorV1: \(error.localizedDescription)")
        }
        
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        print("VixPredictionModel init completed")
    }
    
    // Make a VIX prediction based on input data
    func predict(open: Double, high: Double, low: Double, close: Double) throws -> Double {
        print("predict function called")
        
        print("Input values: Open: \(open), High: \(high), Low: \(low), Close: \(close)")
        
        let input = try MLDictionaryFeatureProvider(dictionary: [
            "Open": open,
            "High": high,
            "Low": low,
            "Close": close
        ])
        
        do {
            print("Attempting prediction...")
            let output = try model.prediction(from: input)
            
            guard let estVix = output.featureValue(for: "EstVix")?.doubleValue else {
                throw VixPredictionError.predictionFailed("EstVix not found in model output")
            }
            
            print("Prediction succeeded")
            print("Predicted EstVix: \(estVix)")
            
            return estVix
        } catch {
            print("Prediction failed: \(error)")
            throw VixPredictionError.predictionFailed("Prediction failed: \(error.localizedDescription)")
        }
    }
}
