//
//  WeatherData.swift
//  WxCoreLocate_V1
//
//  Created by ATS on 3/11/24
//  Revised on 3/12/24
//

/*
 
 Abstract:
 
 Data transfer criteria
 
 References:

 www.youtube.com/@Cebraiil
 
 https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
 
 https://developer.apple.com/documentation/swift/codable
 
 https://developer.apple.com/documentation/objectivec/nsobject/
 
 */

import Foundation
import CoreLocation

struct WeatherData {
    let locationName: String
    let temperature: Double
    let condition: String
}

struct WeatherResponse: Codable {
    let name: String
    let main: MainWeather
    let weather: [Weather]
}

struct MainWeather: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    overide init() {
        super.init()
        locationManager.delegate = self
    }
}
