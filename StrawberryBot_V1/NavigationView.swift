//
//  AppViews Group
//  NavigationView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 

/*
 Abstract:
 
 The navigation view allows the user to select a view that either:
     1. photographs a plant
     2. analyzes the plant photograph
     3. shows the garden's weather
     4. shows the garden's location
 
 References:
 
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app
 
 https://developer.apple.com/tutorials/swiftui-concepts/maintaining-the-adaptable-sizes-of-built-in-views
 
 https://developer.apple.com/tutorials/Sample-Apps
 
 */

import SwiftUI

struct NavigationView: View {
    var body: some View {
        
        Image(systemName: "camera")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Button("Take a Plant Checkup Photo!") {
            PhotoView()
        }

            .padding()
        
        Image(systemName: "stethoscope")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Button("Get Plant Checkup Results") {
            CheckupView()
        }

        .padding()
    
        Image(systemName: "cloud")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Button("Garden Weather!") {
            WeatherView()
    }

        .padding()
        
        Image(systemName: "map")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Button("Garden Location Map!") {
            MapView()
        }

            .padding()
        
    }
}

#Preview {
    NavigationView()
}
