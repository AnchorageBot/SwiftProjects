//
//  Main Group
//  ContentView.swift
//  WxKit50_V5
//
//  Created by ATS on 3/28/24
//  Made with Xcode 15.2
//  Commented by Claude on 3/29/24
//  Refactored by Claude on 3/31/24
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents a weather app's main content view, which displays current weather information and a 3-day forecast bar graph with weather images. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

 References:
 - SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
 - SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
 - SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
 - WeatherKit: https://developer.apple.com/weatherkit/get-started/
 - CoreLocate: https://developer.apple.com/documentation/corelocation
 - Xcode 14: Weather App in 50 lines of code with the new WeatherKit - Tech & Code
     www.youtube.com/@TechCode50
 - Anthropic AI Claude
     https://www.anthropic.com
 */

import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    // Define a static constant for the location (Anchorage, Alaska)
    static let location = CLLocation(latitude: 61.21667, longitude: -149.89361)
    
    // Declare a state variable to store the weather data
    // private indicates that it is only used in the ContentView
    @State private var weather: Weather?
    
    // Define an asynchronous function to fetch the weather data
    private func getWeather() async {
        do {
            // Use WeatherService to fetch the weather data for the specified location
            weather = try await WeatherService.shared.weather(for: Self.location)
        } catch {
            // If an error occurs, print the error
            print("Error fetching weather data: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            if let weather = weather {
                // If weather data is available, display it
                VStack {
                    Text("Anchorage")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.blue)
                    
                    Text(weather.currentWeather.temperature.description)
                        .font(.system(size: 40))
                        .padding()
                    
                    Text(weather.currentWeather.pressure.description)
                        .font(.system(size: 30))
                        .padding()
                    
                    Text(weather.currentWeather.condition.description)
                        .font(.title)
                    
                    Image(systemName: weather.currentWeather.symbolName)
                        .font(.largeTitle)
                        .padding(.bottom, 50)
                    
                    // Add a "Forecast" text with a blue font
                    Text("Forecast")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.blue)
                    
                    // Display a bar graph of high temperatures for the next three days
                    ForecastBarGraph(forecasts: Array(weather.dailyForecast.forecast.prefix(3)))
                }
            } else {
                // If weather data is not available, show a progress view and fetch the data
                ProgressView()
                    .task {
                        await getWeather()
                    }
            }
        }
    }
}

// Define a view for the forecast bar graph
struct ForecastBarGraph: View {
    let forecasts: [DayWeather]
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(alignment: .bottom, spacing: 20) {
                    // Center the graph horizontally
                    Spacer()
                    
                    // Iterate over the forecasts array and create a bar for each day
                    ForEach(forecasts, id: \.date) { forecast in
                        VStack {
                            // Display the weather image on top of each bar
                            Image(systemName: forecast.symbolName)
                                .font(.title)
                            
                            // Create a rounded rectangle for each bar, filled with blue color
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.blue)
                                .frame(width: 50, height: CGFloat(forecast.highTemperature.value) * 3)
                            
                            // Display the first letter of the weekday below each bar
                            Text(forecast.date.weekdayInitial)
                                .font(.caption)
                            
                            // Add spacing between the weekday letter and the temperature
                            Spacer()
                                .frame(height: 10)
                            
                            // Display the numeric high temperature below the weekday letter
                            Text("\(Int(forecast.highTemperature.value))°")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 200)
            
            // Add a label for the graph
            Text("High Temperatures")
                .font(.subheadline)
        }
    }
}

// Extension on Date to get the first letter of the weekday
extension Date {
    var weekdayInitial: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEE"
        return String(dateFormatter.string(from: self).prefix(1))
    }
}

// Define a preview provider to display the ContentView in Xcode's preview canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
