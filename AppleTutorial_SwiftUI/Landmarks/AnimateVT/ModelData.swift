/
//  ModelData.swift
//  Landmarks App
//
//  Made with Swift 5.7, Xcode 14.3.1, 8/6/2023
//  Ref: https //developer.apple.com/tutorials/swiftui
//
//  Xcode->File->New->File->Swift File
//

import Foundation
import Combine

// SwiftUI watches for any changes to observable objects that could affect a view
final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
}

var landmarks: [Landmark] = load("landmarkData.json")

// Creates a load(_:) method that fetches JSON data with a given name from the app’s main bundle
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as (T.self):\n\(error)")
    }
}
