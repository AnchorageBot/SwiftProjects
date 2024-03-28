//
//  Main Folder
//  ContentView.swift
//  WxKitIntro_V1
//
//  Created by ATS  and Claude on 3/27/24
//  Made with Xcode 15.2
//

/*
Abstract:
 
 The primary role of a content view is to display the app's data.

References:
 
- About App Development with UIKit
    https://developer.apple.com/documentation/uikit/about_app_development_with_uikit
- UIKit Framework
    https://developer.apple.com/documentation/uikit
- Introduction to WeatherKit (iOS 16) – WWDC 2022 - iOS Academy
    www.youtube.com/@iOSAcademy
- Anthropic AI Claude
    https://www.anthropic.com
*/


import CoreLocation
import WeatherKit
import UIKit

final class ViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    let locationManager = CLLocationManager()
    let service = WeatherService()
    
    let weatherView = WeatherView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserLocation()
    }
    
    // MARK: - Setup
    
    func setupView() {
        view.addSubview(weatherView)
        
        NSLayoutConstraint.activate([
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherView.topAnchor.constraint(equalTo: view.topAnchor),
            weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Location
    
    func getUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func getWeather(location: CLLocation) {
        Task {
            do {
                let result = try await service.weather(for: location)
                print("Current: \(String(describing: result.currentWeather))")
                print("Daily: \(String(describing: result.dailyForecast))")
                print("Minutely: \(String(describing: result.minuteForecast))")
            } catch {
                print(String(describing: error))
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        locationManager.stopUpdatingLocation()
        getWeather(location: location)
    }
}
