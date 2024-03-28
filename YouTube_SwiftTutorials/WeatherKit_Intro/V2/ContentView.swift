//
//  Main Folder
//  ContentView.swift
//  WxKitIntro_V2
//
//  Created by ATS  and Claude on 3/27/24
//  Made with Xcode 15.2
//

/*
Abstract:
The primary role of a content view is to display the app's data.

References:
- Swift UI
    https://developer.apple.com/xcode/swiftui/
- Swift UI - Apple Deve
    https://developer.apple.com/documentation/swiftui/
- Introduction to WeatherKit (iOS 16) – WWDC 2022 - iOS Academy
    www.youtube.com/@iOSAcademy
- Anthropic AI Claude
    https://www.anthropic.com
*/

import CoreLocation
import WeatherKit
import SwiftUI

// The main view of the app
struct ContentView: View {
    // Create an instance of the WeatherViewModel as a StateObject
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        // Display the WeatherView and pass the viewModel as an environment object
        WeatherView()
            .environmentObject(viewModel)
    }
}

// The view model responsible for fetching and managing weather data
final class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    // The weather data to be displayed in the view
    @Published var weatherData: Weather?
    
    // An instance of CLLocationManager to handle location updates
    private let locationManager = CLLocationManager()
    
    // An instance of WeatherService to fetch weather data
    private let weatherService = WeatherService.shared
    
    override init() {
        super.init()
        // Set the view model as the delegate of the location manager
        locationManager.delegate = self
    }
    
    // Request the user's location
    func requestLocation() {
        // Request permission to access the user's location while the app is in use
        locationManager.requestWhenInUseAuthorization()
        // Start updating the user's location
        locationManager.startUpdatingLocation()
    }
    
    // Handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get the first location from the array of locations
        guard let location = locations.first else { return }
        // Stop updating the user's location
        locationManager.stopUpdatingLocation()
        
        // Fetch weather data asynchronously
        Task {
            do {
                // Fetch weather data using the WeatherService
                let weather = try await weatherService.weather(for: location)
                // Update the weatherData property on the main thread
                await MainActor.run {
                    weatherData = weather
                }
            } catch {
                // Print any errors that occur while fetching weather data
                print("Error fetching weather: \(error)")
            }
        }
    }
}
