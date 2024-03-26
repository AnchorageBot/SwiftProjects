[Live: WeatherKit + SwiftUI - A Swiftly Tilting Planet](https://www.youtube.com/live/H-CoW6Eurzo?si=3Kfok9Z-PQGxtWeL)

- - - -

[Get started with WeatherKit - Apple Dev](https://developer.apple.com/weatherkit/get-started/)

- - - -

[Anthropic](https://www.anthropic.com)

- - - - 

3rd Draft refactored by Claude

- - - -
How to create this project with Xcode commands:

* Xcode-> File-> New Project -> iOS - App

This creates two files

* ProjectName_App.swift
* ContentView.swift

How to create a View file with keyboard and Xcode commands:

* Command Key (Splat) N -> Swift UI View

How to create JSON files (modify as needed)

* File -> New -> File -> Resource -> GeoJSON

How to create folders to organize app files

* Xcode -> File -> New -> Group

* Then just drag and drop the files into the folders that you have created

- - - -

Main Group

* WeatherKit_V1App.swift
* ContentView.swift

- - - -

WxViews Group

* WeatherData.swift

- - - - 

To use WeatherKit, you need to configure it in your project's settings:
* Open your project in Xcode.
* Select your project in the project navigator.
* Go to the "Signing & Capabilities" tab.
* Click on the "+" button and add the "WeatherKit" capability.

Check your provisioning profile: 
* Ensure that your project is using the correct provisioning profile that includes the WeatherKit entitlement.

