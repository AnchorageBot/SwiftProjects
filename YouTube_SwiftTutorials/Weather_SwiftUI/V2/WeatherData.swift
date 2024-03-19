//
//  WxModel Group
//  WeatherData.swift
//  WxCoreLocate_V2
//
//  Created by Claude and ATS on 3/18/24
//  Xcode 15.2
//

/*
 
 Abstract:
 
   Data transfer criteria
 
 References:
 
   Build a Weather App with SwiftUI | JSON API & CoreLocation Tutorial
   www.youtube.com/@Cebraiil

   https://www.anthropic.com
 
   https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
 
   https://developer.apple.com/documentation/swift/codable
 
   https://developer.apple.com/documentation/objectivec/nsobject/
 
   https://developer.apple.com/documentation/corelocation/configuring_your_app_to_use_location_services
 
   https://developer.apple.com/documentation/corelocation
 
   https://developer.apple.com/documentation/xcode/configuring-the-build-settings-of-a-target
 
 */

import Foundation
import CoreLocation

// MARK: - Weather Models

// Struct representing the current weather conditions
struct CurrentWeather {
    let locationName: String
    let temperature: Double
    let condition: String
}

// Struct representing the response from the weather API
struct WeatherResponse: Codable {
    let name: String
    let main: MainWeather
    let weather: [Weather]
}

// Struct representing the main weather data in the API response
struct MainWeather: Codable {
    let temp: Double
}

// Struct representing the weather condition in the API response
struct Weather: Codable {
    let description: String
}

// MARK: - Location Manager

// Class responsible for managing location updates
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Instance of CLLocationManager to request location updates
    private let locationManager = CLLocationManager()
    
    // Closure to be called when a new location is received
    var onLocationUpdate: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // Request location updates
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Delegate method called when new locations are received
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Call the onLocationUpdate closure with the latest location
        onLocationUpdate?(location)
        locationManager.stopUpdatingLocation()
    }
    
    // Delegate method called when an error occurs while updating location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        // Handle location update failure, display error message to the user if needed
    }
    
    // Delegate method called when the location authorization status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location permission granted, start updating location
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Location permission denied or restricted, handle accordingly (e.g., show an alert)
            print("Location permission denied or restricted")
        case .notDetermined:
            // Location permission not determined yet, request permission
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}
