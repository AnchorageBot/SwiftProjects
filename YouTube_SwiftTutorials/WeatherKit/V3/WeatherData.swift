//
//  WxViews Group
//  WeatherData.swift
//  WeatherKit_V3
//
//  Created by ATS on 3/24/24
//  Made with Xcode 15.2
//  Commented by Claude on 3/25/24
//  Refactored by Claude on 3/25/24
//

/*
 Abstract:
 This script provides the necessary data and formatting for displaying weather information in the app's views.
 
 References:
 - WeatherKit Documentation: https://developer.apple.com/documentation/weatherkit
 - Fetching Weather Data: https://developer.apple.com/documentation/weatherkit/fetching_weather_data
 - Swift Concurrency: https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
 - Date Formatting: https://developer.apple.com/documentation/foundation/dateformatter
 - Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet
 - Anthropic AI Claude
    https://www.anthropic.com
 
*/

import Foundation
import WeatherKit
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    // Published properties to store weather data
    @Published private(set) var currentTemperature = ""
    @Published private(set) var currentCondition = ""
    @Published private(set) var dailyHighLow = "H:0 L:0"
    @Published private(set) var hourlyForecast: [HourWeather] = []
    @Published private(set) var tenDayForecast: [DayWeather] = []
    
    // Instance of WeatherService to fetch weather data
    private let weatherService = WeatherService()
    
    // Coordinates for Seattle location
    private let seattleLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
    
    init() {
        // Fetch current weather data when the view model is initialized
        fetchCurrentWeather()
    }
    
    func fetchCurrentWeather() {
        Task {
            do {
                // Fetch weather data for the Seattle location
                let weather = try await weatherService.weather(for: seattleLocation)
                
                // Update the published properties with the fetched weather data
                currentTemperature = weather.currentWeather.temperature.formatted()
                currentCondition = weather.currentWeather.condition.description
                dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast())"
                
                // Populate the hourly forecast array
                hourlyForecast = weather.hourlyForecast.forecast
                    .filter { isSameHourOrLater(date1: $0.date, date2: Date()) }
                    .map { HourWeather(time: hourFormatter(date: $0.date),
                                       symbolName: $0.symbolName,
                                       temperature: "\($0.temperature.formatted().dropLast())") }
                
                // Populate the ten-day forecast array
                tenDayForecast = weather.dailyForecast.forecast
                    .map { DayWeather(day: dayFormatter(date: $0.date),
                                      symbolName: $0.symbolName,
                                      highTemperature: "\($0.highTemperature.formatted().dropLast())",
                                      lowTemperature: "\($0.lowTemperature.formatted().dropLast())") }
            } catch {
                print("Error fetching weather data", error)
            }
        }
    }
    
    // Format the hour for hourly forecast
    private func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day, .hour], from: date)
        let currentDateComponents = calendar.dateComponents([.day, .hour], from: Date())
        
        return inputDateComponents == currentDateComponents ? "Now" : dateFormatter.string(from: date)
    }
    
    // Check if the given date is the same hour or later than the current date
    private func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1, to: date2, toGranularity: .hour)
        
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    // Format the day for ten-day forecast
    private func dayFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day], from: date)
        let currentDateComponents = calendar.dateComponents([.day], from: Date())
        
        return inputDateComponents == currentDateComponents ? "Today" : dateFormatter.string(from: date)
    }
}

extension WeatherViewModel {
    // Struct to represent hourly weather data
    struct HourWeather {
        let time: String
        let symbolName: String
        let temperature: String
    }
    
    // Struct to represent daily weather data (conforming to Hashable protocol)
    struct DayWeather: Hashable {
        let day: String
        let symbolName: String
        let highTemperature: String
        let lowTemperature: String
    }
}
