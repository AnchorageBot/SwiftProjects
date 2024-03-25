//
//  Main Group
//  ContentView.swift
//  WeatherKit_V1
//
//  Created by ATS on 3/24/24
//  Made with Xcode 15.2
//  Commented by Claude
//

/*
 
 Abstract:
 
    The primary role of a content view is to display the app's data. 
 
 This code represents a weather app's main content view, which displays current weather information, hourly forecast, and a 10-day forecast using data provided by the weatherViewModel. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.
 
 References:
 
    Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet
 
    https://developer.apple.com/weatherkit/get-started/
 
    https://developer.apple.com/tutorials/app-dev-training/managing-content-views/
 
    https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller

    https://www.anthropic.com

 */

import SwiftUI

struct ContentView: View {
    
    // Create a StateObject to manage the view's state
    @StateObject private var weatherViewModel = weatherViewModel()
    
    var body: some View {
        
        ZStack {
            
            // Apply a linear gradient background
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .orange]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 8) {
                    
                    // Display the city name
                    Text("Seattle")
                        .font(.title)
                    
                    // Display the current temperature
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size: 72))
                        .fontWeight(.light)
                    
                    // Display the current weather condition
                    Text(weatherViewModel.currentCondition)
                    
                    // Display the daily high and low temperatures
                    Text(weatherViewModel.dailyHighLow)
                    
                }
                .foregroundColor(.white)
                .padding()
                
                VStack(alignment: .leading) {
                    
                    // Display the label for the hourly forecast section
                    Label("hourly forecast".uppercased(), systemImage: "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal) {
                        
                        HStack {
                            
                            // Loop through the hourly forecast data
                            ForEach(weatherViewModel.hourlyForecast, id: \.time) {
                                weather in
                                VStack(spacing: 12) {
                                    
                                    // Display the time for each hourly forecast
                                    Text(weather.time)
                                        .font(.caption)
                                    
                                    // Display the weather symbol for each hourly forecast
                                    Image(systemName: "\(weather.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    
                                    // Display the temperature for each hourly forecast
                                    Text(weather.temperature)
                                        .fontWeight(.semibold)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
                
                VStack(alignment: .leading) {
                    
                    // Display the label for the 10-day forecast section
                    Label("10-day forecast".uppercased(), systemImage: "calendar")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    VStack {
                        
                        // Loop through the 10-day forecast data
                        ForEach(weatherViewModel.tenDayForecast, id: \.self) {
                            weather in
                            
                            HStack {
                                
                                // Display the day for each forecast
                                Text(weather.day)
                                    .frame(width: 48, alignment: .leading)
                                
                                // Display the weather symbol for each forecast
                                Image(systemName: "\(weather.symbolName).fill")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .symbolRenderingMode(.multicolor)
                                
                                // Display the low temperature for each forecast
                                Text(weather.lowTemperature)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                ZStack(alignment: .trailing) {
                                    
                                    // Display a capsule shape for the temperature range
                                    Capsule()
                                    
                                    // Apply a linear gradient to the temperature range capsule
                                    LinearGradient(gradient: Gradient(colors: [.blue, .yellow]),
                                                   startPoint: .leading, endPoint: .trailing)
                                        .clipShape(Capsule())
                                        .frame(width: 72)
                                }
                                .frame(height: 6)
                                
                                // Display the high temperature for each forecast
                                Text(weather.highTemperature)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
#Preview {
    ContentView()
}
*/
