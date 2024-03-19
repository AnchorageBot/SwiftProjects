//
//  Main Group
//  ContentView.swift
//  WxCoreLocate_V1
//
//  Created by ATS on 3/11/24
//  Revised on 3/18/24
//  Xcode 15.2
//

/*
 
 Abstract:
 
    The primary role of a content view is to display the app’s data. A view controller manages a view hierarchy and the state information needed to keep those views up-to-date
 
 References:
 
    Build a Weather App with SwiftUI | JSON API & CoreLocation Tutorial
    www.youtube.com/@Cebraiil
 
    https://developer.apple.com/tutorials/app-dev-training/managing-content-views/
 
    https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller
 
    https://developer.apple.com/documentation/uikit/view_controllers/managing_content_in_your_app_s_windows/
 
    https://developer.apple.com/documentation/uikit/uicollectionviewcell/1620133-contentview/
 
    https://www.meteomatics.com
 
    https://www.meteomatics.com/en/weather-api/
 
 */


import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    
    var body: some View {
        VStack {
            
            if let weatherData = weatherData {
                Text("\(Int(weatherData.temperature))C")
                    .font(.custom("", size: 70))
                    .padding()
                
                VStack{
                    Text("\(weatherData.locationName)")
                        .font(.title2).bold()
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("CodeLab")
                    .bold()
                    .padding()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            } else {
                ProgressView()
            }
        }
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .onAppear {
            locationManager.requestLocation()
        }
        .onReceive(locationManager.$location) { location in
            guard let location = location else { return }
            fetchWeatherData(for: location)
        }
    }
    
    private func fetchWeatherData(for location: CLLocation) {
        let apiKey = ""
        let urlString = ""
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _ , error in guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                
                DispatchQueue.main.async {
                    weatherData = weatherData(locationName: weatherResponse.name, temperature:
                        weatherResponse.main.temp, condition:
                        weatherResponse.weather.first?.description ?? "")
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}

#Preview {
    ContentView()
}
