//
//  ContentView.swift
//  WeatherPrototype
//
//  Created by ATS on 4/6/24
//  Made with Xcode 15.3
//  Revised on 4/7/24
//  Commented by Claude on 4/7/24
//

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents a weather app's main content view, which displays current weather information and a 3-day forecast with weather images. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

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

struct ContentView: View { // Defines the ContentView struct, which conforms to the View protocol
    var body: some View { // Defines the view's content and layout
        HStack { // Arranges the DayForecast views horizontally
            DayForecast(day: "Mon", seeSun: true, high: 50, low: 40) // Initializes a DayForecast view for Monday
            DayForecast(day: "Tue", seeSun: false, high: 40, low: 30) // Initializes a DayForecast view for Tuesday
            DayForecast(day: "Wed", seeSun: true, high: 50, low: 40) // Initializes a DayForecast view for Wednesday
        }
    }
}

#Preview { // Provides a preview of the ContentView in Xcode's preview canvas
    ContentView()
}

struct DayForecast: View { // Defines the DayForecast struct, which represents a single day's weather forecast
    let day: String // The day of the forecast
    let seeSun: Bool // Indicates whether the sun is visible or not
    let high: Int // The high temperature for the day
    let low: Int // The low temperature for the day
    
    var WxEmojiName: String { // Computed property that determines the appropriate SF Symbol name based on the seeSun property
        if seeSun {
            return "sun.max.fill"
        } else {
            return "cloud.snow.fill"
        }
    }
    
    var WxEmojiColor: Color { // Computed property that determines the color of the weather emoji based on the seeSun property
        if seeSun {
            return Color.yellow
        } else {
            return Color.blue
        }
    }
    
    var body: some View { // Defines the layout of the DayForecast view
        VStack { // Arranges the views vertically
            Text(day) // Displays the day
                .font(Font.headline)
            Image(systemName: WxEmojiName) // Displays the weather emoji
                .foregroundColor(WxEmojiColor)
                //.foregroundStyle(WxEmojiColor)
                .font(Font.largeTitle)
                .padding()
            // to display the value of a number in a text view, which expects a String, you have to change the number into a string
            Text("High: \(high)") // Displays the high temperature
                //.fontWeight(Font.Weight.semibold)
                //.fontWeight(Font.Weight.medium)
            Text("Low: \(low)") // Displays the low temperature
                .fontWeight(Font.Weight.semibold)
                //.fontWeight(Font.Weight.medium)
        }
        .padding()
    }
}
