//
//  Main Group
//  ContentView.swift
//  WeatherKit_V1
//
//  Created by ATS on 3/24/24
//  Made with Xcode 15.2
//  

/*
 
 Abstract:
 
    The primary role of a content view is to display the app’s data. A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
 
 References:
 
    Live: WeatherKit + SwiftUI
    www.youtube.com/@a_swiftly_tilting_planet

    https://developer.apple.com/weatherkit/get-started/
 
    https://developer.apple.com/tutorials/app-dev-training/managing-content-views/
 
    https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller
 
 */

import SwiftUI

struct ContentView: View {
    
    @StateObject private var weatherViewModel = weatherViewModel()
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .orange]),
                           startPoint: .top, endPoint: .bottom) .edgesIgnoringSafeArea(.vertical)
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 8) {
                    
                    Text("Seattle")
                        .font(.title)
                    
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size: 72))
                        .fontWeight(.light)
                    
                    Text(weatherViewModel.currentCondition)
                    
                    Text(weatherViewModel.dailyHighLow)
                    
                }
                .foregroundColor(.white)
                .padding()
                
                VStack(alignment: .leading) {
                    
                    Label("hourly forecast".uppercased(), systemImage: "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal) {
                        
                        HStack {
                            
                            ForEach(weatherViewModel.hourlyForecast, id: \.time) {
                                weather in
                                VStack(spacing: 12) {
                                    
                                    Text(weather.time)
                                        .font(.caption)
                                    
                                    Image(systemName: "\(weather.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    
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
                    
                    Label("10-day forecast".uppercased(), systemImage: "calendar")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    VStack {
                        
                        ForEach(weatherViewModel.tenDayForecast, id: \.self) {
                            weather in
                            
                            HStack {
                                
                                Text(weather.day)
                                    .frame(width: 48, alignment: .leading)
                                
                                Image(systemName: "\(weather.symbolName).fill")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .symbolRenderingMode(.multicolor)
                                
                                Text(weather.lowTemperature)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                ZStack(alignment: .trailing) {
                                    
                                    Capsule()
                                    
                                    LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .leading, endPoint: .trailing)
                                        .clipShape(Capsule())
                                        .frame(width: 72)
                                }
                                .frame(height: 6)
                                
                                Text(weather.highTemperature)
                                    .fontWeight(.semibold)
                            }
                            .padding()
                        }
                    }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8)).padding()
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
