//
//  Main Group
//  ContentView.swift
//  WxKit50_V3
//
//  Created by ATS on 3/28/24
//  Made with Xcode 15.2
//  Commented by Claude on 3/29/24
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents a weather app's main content view, which displays current weather information. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Xcode 14: Weather App in 50 lines of code with the new WeatherKit - Tech & Code
    www.youtube.com/@TechCode50
- Anthropic AI Claude
    https://www.anthropic.com
*/

// Import the necessary frameworks
import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    // Define a static constant for the location (Anchorage, Alaska)
    static let location = CLLocation(
        latitude: .init(floatLiteral: 61.21667), longitude: .init(floatLiteral: -149.89361)
    )
    
    // Declare a state variable to store the weather data
    @State var weather: Weather?
    
    // Define an asynchronous function to fetch the weather data
    func getWeather() async {
        do {
            // Use WeatherService to fetch the weather data for the specified location
            weather = try await Task {
                try await WeatherService.shared.weather(for: Self.location)
            }.value
        } catch {
            // If an error occurs, terminate the app and print the error
            fatalError("\(error)")
        }
    }
    
    var body: some View {
        if let weather = weather {
            // If weather data is available, display it
            VStack {
                Text("Anchorage").font(.largeTitle).padding().foregroundColor(.blue)
                Text(weather.currentWeather.temperature.description)
                    .font(.system(size: 40)).padding()
                Text(weather.currentWeather.pressure.description)
                    .font(.system(size: 30)).padding()
                Text(weather.currentWeather.condition.description).font(.title)
                Image(systemName: weather.currentWeather.symbolName).font(.title)
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

// Define a preview provider to display the ContentView in Xcode's preview canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
