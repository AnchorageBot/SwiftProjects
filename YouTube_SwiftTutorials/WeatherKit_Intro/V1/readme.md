


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

- - - - 

To use WeatherKit, you need to configure it in your project's settings:
* Open your project in Xcode.
* Select your project in the project navigator.
* Go to the "Signing & Capabilities" tab.
* Click on the "+" button and add the "WeatherKit" capability.

Ensure that your project is using the correct provisioning profile that includes the WeatherKit entitlement:
* Go to the Apple Developer portal (https://developer.apple.com/).
* Navigate to the "Certificates, Identifiers & Profiles" section.
* Locate your provisioning profile
