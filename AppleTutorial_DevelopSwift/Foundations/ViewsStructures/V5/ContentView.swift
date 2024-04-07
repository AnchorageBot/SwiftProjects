//
//  ContentView.swift
//  WeatherPrototype
//
//  Created by ATS on 4/6/24
//  Made with Xcode 15.3
//  Revised on 4/7/24
//  Refactored and commented by Claude on 4/7/24
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
            DayForecast(day: "Mon", isSunny: true, high: 50, low: 40) // Initializes a DayForecast view for Monday
            DayForecast(day: "Tue", isSunny: false, high: 40, low: 30) // Initializes a DayForecast view for Tuesday
            DayForecast(day: "Wed", isSunny: true, high: 50, low: 40) // Initializes a DayForecast view for Wednesday
        }
    }
}

#Preview { // Provides a preview of the ContentView in Xcode's preview canvas
    ContentView()
}
