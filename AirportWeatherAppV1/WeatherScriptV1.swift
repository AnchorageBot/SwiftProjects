// This script will generate weather data for Anchorage, Alaska

/* 
 
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7
 
 References: Apple WeatherKit 
 
 */

import WeatherKit
import CoreLocation

let weatherService = WeatherService()
let Anchorage = CLLocation(latitude: 61, longitude: -149)
let weather = try! await weatherService.weather(for: Anchorage)
let temperature = weather.currentWeather.temperature

print(temperature) 
