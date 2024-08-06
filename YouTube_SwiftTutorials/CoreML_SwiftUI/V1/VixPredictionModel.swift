//
// VixData
// VixPredictionModel.swift
//
// Created on 8/5/24
// Swift Version 5.0
//
// ATS Project
//


import Foundation
import CoreML

struct VixPredictionModel {
    private let model: _24_07_VixData_Auto
    
    init() throws {
        let config = MLModelConfiguration()
        self.model = try _24_07_VixData_Auto(configuration: config)
    }
    
    func predict(date: Date, open: Double, high: Double, low: Double, close: Double) throws -> Double {
        let input = _24_07_VixData_AutoInput(
            Date: date,
            Open: open,
            High: high,
            Low: low,
            Close: close
        )
        
        let prediction = try model.prediction(input: input)
        return prediction.AdjVix
    }
}
