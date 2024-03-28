//
//  WxView.swift
//  WxKitIntro_V1
//
//  Created by ATS and Claude on 3/27/24
//

/*
Abstract:
A view that provides weather data for a location

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

import WeatherKit
import SwiftUI

struct WeatherView: View {
    // Access the WeatherViewModel from the environment
    @EnvironmentObject private var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Check if weather data is available
            if let weather = viewModel.weatherData {
                // Display current weather information
                let currentWeather = weather.currentWeather
                
                // Display the weather icon
                Image(systemName: currentWeather.symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(.white)
                
                // Display the weather condition description
                Text(currentWeather.condition.description)
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Display the current temperature
                Text(currentWeather.temperature.formatted())
                    .font(.system(size: 55, weight: .regular))
                    .foregroundColor(.white)
                
                // Display daily forecast
                let dailyForecast = weather.dailyForecast
                
                Text("Daily Forecast")
                    .font(.title)
                    .foregroundColor(.white)
                
                // Iterate over the daily forecast and display each day's information
                ForEach(dailyForecast.forecast, id: \.date) { day in
                    Text("\(day.date.formatted()): \(day.condition.description)")
                        .foregroundColor(.white)
                }
                
                // Display minute forecast
                let minuteForecast = weather.minuteForecast
                
                Text("Minute Forecast")
                    .font(.title)
                    .foregroundColor(.white)
                
                // Iterate over the minute forecast and display each minute's information
                ForEach(minuteForecast.forecast, id: \.date) { minute in
                    Text("\(minute.date.formatted()): \(minute.precipitation.description)")
                        .foregroundColor(.white)
                }
            } else {
                // Display a progress view while weather data is being fetched
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .onAppear {
            // Request the user's location when the view appears
            viewModel.requestLocation()
        }
    }
}

// A preview provider for the WeatherView
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .environmentObject(WeatherViewModel())
    }
}
