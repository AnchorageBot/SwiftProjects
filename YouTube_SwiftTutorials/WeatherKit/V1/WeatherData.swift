//
//  WxViews Group
//  WeatherData.swift
//  WeatherKit_V1
//
//  Created by ATS on 3/24/24
//  Made with Xcode 15.2
//  Commented by Claude on 3/25/24
//

/*
 
 Abstract:
 
 This script provides the necessary data and formatting for displaying weather information in the app's views.
 
 References:
 
    Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet
 
    https://developer.apple.com/weatherkit/get-started/
 
 */

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    // Published properties to store weather data
    @Published private(set) var currentTemperature = String()
    @Published private(set) var currentCondition = String()
    @Published private(set) var dailyHighLow = "H:0 L:0"
    @Published private(set) var hourlyForecast = [HourWeather]()
    @Published private(set) var tenDayForecast = [DayWeather]()
    
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
                
                // Update the published properties on the main queue
                DispatchQueue.main.async {
                    self.currentTemperature = weather.currentWeather.temperature.formatted()
                    self.currentCondition = weather.currentWeather.condition.description
                    self.dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast())"
                    
                    // Populate hourly forecast array
                    weather.hourlyForecast.forecast.forEach {
                        if self.isSameHourOrLater(date1: $0.date, date2: Date()) {
                            self.hourlyForecast.append(HourWeather(time: self.hourFormatter(date: $0.date), symbolName: $0.symbolName, temperature: "\($0.temperature.formatted().dropLast())"))
                        }
                    }
                    
                    // Populate ten-day forecast array
                    weather.dailyForecast.forecast.forEach {
                        self.tenDayForecast.append(DayWeather(day: self.dayFormatter(date: $0.date), symbolName: $0.symbolName, highTemperature: "\($0.highTemperature.formatted().dropLast())", lowTemperature: "\($0.lowTemperature.formatted().dropLast())"))
                    }
                }
            } catch {
                print("Error fetching weather data", error)
            }
        }
    }
    
    // Format the hour for hourly forecast
    func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day, .hour], from: date)
        let currentDateComponents = calendar.dateComponents([.day, .hour], from: Date())
        
        if inputDateComponents == currentDateComponents {
            return "Now"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    // Check if the given date is the same hour or later than the current date
    func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1, to: date2, toGranularity: .hour)
        
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    // Format the day for ten-day forecast
    func dayFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day], from: date)
        let currentDateComponents = calendar.dateComponents([.day], from: Date())
        
        if inputDateComponents == currentDateComponents {
            return "Today"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    // Struct to represent hourly weather data
    struct HourWeather {
        let time: String
        let symbolName: String
        let temperature: String
    }
    
    // Struct to represent daily weather data (conforming to Hashable protocol)
    struct DayWeather: Hashable {
        let day: String
        let lowTemperature: String
        let highTemperature: String
    }
}
