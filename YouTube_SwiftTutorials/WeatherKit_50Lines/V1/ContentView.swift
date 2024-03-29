//
//  Main Group
//  ContentView.swift
//  WxKit50_V1
//
//  Created by ATS on 3/28/24
//  Made with Xcode 15.2
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

import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    
    static let location = CLLocation(
        latitude: .init(floatLiteral: 33.684422), longitude: .init(floatLiteral: 73.047882)
    )
    
    @State var weather: Weather?
    
    func getWeather() async {
        do {
            weather = try await Task
            {
                try await WeatherService.shared.weather(for: Self.location)}.value
        } catch {
            fatalError("\(error)")
        }
    }
    
    var body: some View {
        
        if let weather = weather {
            
            VStack {
                Text("Islamabad").font(.largeTitle).padding().foregroundColor(.blue)
                Text(weather.currentWeather.temperature.description)
                    .font(.system(size: 60))
                Text(weather.currentWeather.condition.description).font(.title)
                Image(systemName: weather.currentWeather.symbolName).font(.title)
            }
            
        } else {
            ProgressView()
                .task {
                    await getWeather()
                }
        }
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
