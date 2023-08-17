//
//  Hike.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/6/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->File->Swift File
//

import Foundation

struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]
    
    static var formatter = LengthFormatter()
    
    var distanceText: String {
        Hike.formatter
            .string(fromValue: distance, unit: .kilometer)
    }
    
    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}
