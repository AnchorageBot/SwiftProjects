//
//  WeatherData.swift
//  WxCoreLocate_V1
//
//  Created by ATS on 3/11/24
//  Revised on 3/16/24
//  Xcode 15.2
//

/*
 
 Abstract:
 
   Data transfer criteria
 
 References:
 
   www.youtube.com/@Cebraiil
 
   https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types
 
   https://developer.apple.com/documentation/swift/codable
 
   https://developer.apple.com/documentation/objectivec/nsobject/
 
   https://developer.apple.com/documentation/corelocation/configuring_your_app_to_use_location_services
 
   https://developer.apple.com/documentation/corelocation
 
   https://developer.apple.com/documentation/xcode/configuring-the-build-settings-of-a-target
 
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
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.location = location
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

