//
//  WxViews Group
//  WeatherData.swift
//  WeatherKit_V1
//
//  Created by ATS on 3/24/24
//  Made with Xcode 15.2
//

/*
 
 Abstract:
 
    Provides critera for weatherkit and corelation parameters
 
 References:
 
    Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet
 
    https://developer.apple.com/weatherkit/get-started/
 
 */

import Foundation

import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published private(set) var currentTemperature = String()
    @Published private(set) var currentCondition = String()
    @Published private(set) var dailyHighLow = "H:0 L:0"
    @Published private(set) var hourlyForecast = [HourWeather]()
    @Published private(set) var tenDayForecast = [DayWeather]()
    
    private let weatherService = WeatherService()
    private let seattleLocation = CLLocation(latitude: 47.6062, longitude: -122.3321)
    
    init() {
        fetchCurrentWeather()
    }
    
    func fetchCurrentWeather() {
        Task {
            do {
                let weather = try await weatherService.weather(for: seattleLocation)
                DispatchQueue.main.async {
                    self.currentTemperature = weather.currentWeather.temperature.formatted()
                    self._currentCondition = weather.currentWeather.condition.description
                    self.dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast())"
                    
                    // hourly forecast
                    weather .hourlyForecast .forecast .forEach {
                        if self.isSameHourOrLater(date1: $0.date, date2: Date()) {
                            self.hourlyForecast.append(HourWeather(time: self.hourFormatter(date: $0.date), symbolName: $0.symbolName, temperature: "\($0.temperature.formatted().dropLast())"))
                        }
                    }
                    
                    // ten day forecast
                    weather.dailyForecast.forecast.forEach {
                        self.tenDayForecast.append(DayWeather(day: self.dayFormatter(date: $0.date), symbolName: $0.symbolName, lowTemperature: "\($0.highTemperature.formatted().dropLast())"))
                    }
                }
            } catch {
                print("Error fetching weather data", error)
            }
        }
    }
    
    func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        
        let inputDateComponents = calendar.dateComponents([.day, .hour], from:date)
        let currentDateComponents = calendar.dateComponents([.day, .hour], from:Date())
        
        if inputDateComponents == currentDateComponents {
            return "Now"
        } else {
            return dateFormatter.string(from: date)
        }
    }
    
    func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1, to: date2, toGranularity: .hour)
        
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    // video location 19:02/27:27
    
    
    struct HourWeather {
        let time: String
        let symbolName: String
        let temperature: String
    }
    
    struct DayWeather: Hashable {
        let day: String
        let lowTemperature: String
        let highTemperature: String
    }
}
