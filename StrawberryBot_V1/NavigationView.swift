//
//  AppViews Group
//  NavigationView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2, Swift 5.9
//  Last revised on 3/8/24 by ATS and Claude
//

/*
  Abstract:
  
  The navigation view allows the user to select a view that either:
      1. Takes the user to the content view
      2. photographs a plant
      3. analyzes the plant photograph
      4. shows the garden's weather
      5. shows the garden's location
  
  References:
  
  https://developer.apple.com/tutorials/Sample-Apps
  
  */

import SwiftUI

struct NavigationView: View {
    @State private var isShowingContentView = false
    @State private var isShowingPhotoView = false
    @State private var isShowingCheckupView = false
    @State private var isShowingWeatherView = false
    @State private var isShowingMapView = false
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: ContentView(), isActive: $isShowingContentView) {
                Button {
                    isShowingContentView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "house.circle.fill")
                        Text("Home")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            NavigationLink(destination: PhotoView(), isActive: $isShowingPhotoView) {
                Button {
                    isShowingPhotoView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "camera.circle.fill")
                        Text("Photo")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            NavigationLink(destination: CheckupView(), isActive: $isShowingCheckupView) {
                Button {
                    isShowingCheckupView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "stethoscope.circle.fill")
                        Text("Checkup")
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            NavigationLink(destination: WeatherView(), isActive: $isShowingWeatherView) {
                Button {
                    isShowingWeatherView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "cloud.circle.fill")
                        Text("Weather")
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            
            NavigationLink(destination: MapView(), isActive: $isShowingMapView) {
                Button {
                    isShowingMapView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "map.circle.fill")
                        Text("Map")
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}
 
// Preview for Navigation View - current version of Swift is 5.9
#Preview {
    NavigationView()
         }
