//
//  Main Group
//  ContentView.swift
//  WxCoreLocate_V2
//
//  Created by Claude and ATS on 3/18/24
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
  
 */

import SwiftUI
import CoreLocation

struct ContentView: View {
    // ViewModel instance to manage weather data and location updates
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            // Check if weather data is available
            if let weatherData = viewModel.weatherData {
                // Display the temperature
                Text("\(Int(weatherData.temperature))°C")
                    .font(.custom("", size: 70))
                    .padding()
                
                VStack {
                    // Display the location name
                    Text(weatherData.locationName)
                        .font(.title2).bold()
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                // Display the app name
                Text("CodeLab")
                    .bold()
                    .padding()
                    .foregroundColor(.blue)
            } else {
                // Show a progress view while fetching weather data
                ProgressView()
            }
        }
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .onAppear {
            // Request location updates when the view appears
            viewModel.requestLocation()
        }
    }
}

// ViewModel class to handle weather data and location updates
class WeatherViewModel: ObservableObject {
    // Published property to store the current weather data
    @Published var weatherData: CurrentWeather?
    
    // Instance of LocationManager to handle location updates
    private let locationManager = LocationManager()
    
    init() {
        // Set the callback for location updates
        locationManager.onLocationUpdate = { [weak self] location in
            // Fetch weather data when a new location is received
            self?.fetchWeatherData(for: location)
        }
    }
    
    // Request location updates from the LocationManager
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    // Fetch weather data for the given location using the APIClient
    private func fetchWeatherData(for location: CLLocation) {
        APIClient.shared.fetchWeatherData(for: location) { [weak self] (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let weatherResponse):
                // Update the weatherData property on the main queue
                DispatchQueue.main.async {
                    self?.weatherData = CurrentWeather(
                        locationName: weatherResponse.name,
                        temperature: weatherResponse.main.temp,
                        condition: weatherResponse.weather.first?.description ?? ""
                    )
                }
            case .failure(let error):
                // Handle any errors that occur during the API request
                print(error.localizedDescription)
            }
        }
    }
}
