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
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        WeatherView()
            .environmentObject(viewModel)
    }
}

final class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather.CurrentWeather?
    @Published var dailyForecast: Weather.DailyForecast?
    @Published var minuteForecast: Weather.MinuteForecast?
    
    private let locationManager = CLLocationManager()
    private let weatherService = WeatherService.shared
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        
        Task {
            do {
                let weather = try await weatherService.weather(for: location)
                await MainActor.run {
                    currentWeather = weather.currentWeather
                    dailyForecast = weather.dailyForecast
                    minuteForecast = weather.minuteForecast
                }
            } catch {
                print("Error fetching weather: \(error)")
            }
        }
    }
}

struct WeatherView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel
    
    var body: some View {
        VStack {
            if let currentWeather = viewModel.currentWeather {
                Text("Current Weather")
                    .font(.title)
                Text("Temperature: \(currentWeather.temperature.formatted())")
                Text("Condition: \(currentWeather.condition.description)")
            }
            
            if let dailyForecast = viewModel.dailyForecast {
                Text("Daily Forecast")
                    .font(.title)
                ForEach(dailyForecast.forecast, id: \.date) { day in
                    Text("\(day.date.formatted()): \(day.condition.description)")
                }
            }
            
            if let minuteForecast = viewModel.minuteForecast {
                Text("Minute Forecast")
                    .font(.title)
                ForEach(minuteForecast.forecast, id: \.date) { minute in
                    Text("\(minute.date.formatted()): \(minute.precipitation.description)")
                }
            }
        }
        .onAppear {
            viewModel.requestLocation()
        }
    }
}
