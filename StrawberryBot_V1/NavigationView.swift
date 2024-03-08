//
//  AppViews Group
//  NavigationView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2, Swift 5.9
//  Last revised on 3/8/24 by ATS and Claude

/*
 Abstract:
 
 The navigation view allows the user to select the following views
    1. Home page (ContentView)
    2. photographs a plant (PhotoView)
    3. analyzes the plant photograph (CheckupView)
    4. shows the garden's weather (WeatherView)
    5. shows the garden's location (MapView)
 
 References:
 
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app
 
 https://developer.apple.com/tutorials/swiftui-concepts/maintaining-the-adaptable-sizes-of-built-in-views
 
 https://developer.apple.com/tutorials/Sample-Apps
 
 https://developer.apple.com/documentation/swiftui/button
 
 */

import SwiftUI

struct NavigationView: View {
    
    // State variable to control the presentation of ContentView
    @State private var isShowingContentView = false
    
    // State variable to control the presentation of PhotoView
    @State private var isShowingPhotoView = false
    
    // State variable to control the presentation of CheckupView
    @State private var isShowingCheckupView = false
    
    // State variable to control the presentation of WeatherView
    @State private var isShowingWeatherView = false
    
    // State variable to control the presentation of MapView
    @State private var isShowingMapView = false
    
    var body: some View {
        
        VStack {
            
            // NavigationLink to navigate to ContentView
            NavigationLink(
                destination: ContentView(), // The view to navigate to
                isActive: $isShowingContentView // Binding to control the navigation
            ) {
                // Button to trigger the navigation to ContentView
                Button {
                    isShowingContentView.toggle() // Toggle the state variable when tapped
                } label: {
                    Image(systemName: "house.circle.fill") // Button image
                }
                
                // NavigationLink to navigate to PhotoView
                NavigationLink(
                    destination: PhotoView(), // The view to navigate to
                    isActive: $isShowingPhotoView // Binding to control the navigation
                ) {
                    // Button to trigger the navigation to PhotoView
                    Button {
                        isShowingPhotoView.toggle() // Toggle the state variable when tapped
                    } label: {
                        Image(systemName: "camera.circle.fill") // Button image
                    }
                }
                
                // NavigationLink to navigate to CheckupView
                NavigationLink(
                    destination: CheckupView(), // The view to navigate to
                    isActive: $isShowingCheckupView // Binding to control the navigation
                ) {
                    // Button to trigger the navigation to CheckupView
                    Button {
                        isShowingCheckupView.toggle() // Toggle the state variable when tapped
                    } label: {
                        Image(systemName: "stethoscope.circle.fill") // Button image
                    }
                }
                
                // NavigationLink to navigate to WeatherView
                NavigationLink(
                    destination: WeatherView(), // The view to navigate to
                    isActive: $isShowingWeatherView // Binding to control the navigation
                ) {
                    // Button to trigger the navigation to WeatherView
                    Button {
                        isShowingWeatherView.toggle() // Toggle the state variable when tapped
                    } label: {
                        Image(systemName: "cloud.circle.fill") // Button image
                    }
                }
               
                // NavigationLink to navigate to MapView
                NavigationLink(
                    destination: MapView(), // The view to navigate to
                    isActive: $isShowingMapView // Binding to control the navigation
                ) {
                    // Button to trigger the navigation to WeatherView
                    Button {
                        isShowingMapView.toggle() // Toggle the state variable when tapped
                    } label: {
                        Image(systemName: "cloud.circle.fill") // Button image
                    }
                }
                
            }
        }
    }
}

/*

// Preview for NavigationView - older version of Swift
struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
*/

 
// Preview for Navigation View - current version of Swift is 5.9
#Preview {
    NavigationView()
         }
