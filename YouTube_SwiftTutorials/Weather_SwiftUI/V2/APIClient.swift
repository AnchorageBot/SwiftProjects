//
//  WxModel Group
//  APIClient.swift
//  WxCoreLocate_V2
//
//  Created by Claude and ATS on 3/18/24
//  Xcode 15.2
//

/*
 
 Abstract:
 
   API access criteria
 
 References:
 
   Build a Weather App with SwiftUI | JSON API & CoreLocation Tutorial
   www.youtube.com/@Cebraiil
 
    https://openweathermap.org/api
 
    https://openweathermap.org/api/one-call-3
 
    https://www.meteomatics.com

    https://www.meteomatics.com/en/weather-api/
 
 */

import Foundation
import CoreLocation

class APIClient {
    // Singleton instance of the APIClient
    static let shared = APIClient()
    
    // Private initializer to prevent creating multiple instances
    private init() {}
    
    // Method to fetch weather data for a given location
    func fetchWeatherData(for location: CLLocation, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        // Replace "YOUR_API_KEY" with your actual API key
        let apiKey = "YOUR_API_KEY"
        
        // Construct the URL string with the location coordinates and API key
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        
        // Convert the URL string to a URL object
        guard let url = URL(string: urlString) else {
            // If the URL is invalid, call the completion handler with an error
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create a data task to perform the API request
        URLSession.shared.dataTask(with: url) { data, _, error in
            // Check if an error occurred during the request
            if let error = error {
                // Call the completion handler with the error
                completion(.failure(error))
                return
            }
            
            // Check if data was received from the API
            guard let data = data else {
                // If no data was received, call the completion handler with an error
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                // Create a JSON decoder
                let decoder = JSONDecoder()
                
                // Decode the received data into a WeatherResponse object
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                
                // Call the completion handler with the decoded weather response
                completion(.success(weatherResponse))
            } catch {
                // If an error occurred during decoding, call the completion handler with the error
                completion(.failure(error))
            }
        }.resume() // Start the data task
    }
}
