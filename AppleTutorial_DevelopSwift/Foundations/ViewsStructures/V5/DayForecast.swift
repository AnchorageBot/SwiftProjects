//
//  DayForecast.swift
//  WeatherPrototype
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Refactored and commented by Claude on 4/7/24
//

/*
Abstract:
This code defines the DayForecast struct, which represents a single day's weather forecast. It displays the day, weather emoji, high temperature, and low temperature. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- WeatherKit: https://developer.apple.com/weatherkit/get-started/
- CoreLocate: https://developer.apple.com/documentation/corelocation
- Develop in Swift Tutorials - Views, structures, and properties
    https://developer.apple.com/tutorials/develop-in-swift/customize-views-with-properties
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI // Imports the SwiftUI framework

struct DayForecast: View { // Defines the DayForecast struct, which conforms to the View protocol
    let day: String // The day of the forecast
    let isSunny: Bool // Indicates whether the day is sunny or not
    let high: Int // The high temperature for the day
    let low: Int // The low temperature for the day
    
    var weatherEmoji: some View { // Computed property that determines the appropriate weather emoji based on the isSunny property
        switch isSunny {
        case true:
            return Image(systemName: "sun.max.fill")
                .foregroundColor(.yellow)
        case false:
            return Image(systemName: "cloud.snow.fill")
                .foregroundColor(.blue)
        }
    }
    
    var body: some View { // Defines the layout of the DayForecast view
        VStack { // Arranges the views vertically
            Text(day) // Displays the day
                .font(.headline)
            weatherEmoji // Displays the weather emoji
                .font(.largeTitle)
                .padding()
            Text("High: \(high)") // Displays the high temperature
            Text("Low: \(low)") // Displays the low temperature
                .fontWeight(.semibold)
        }
        .padding()
    }
}
