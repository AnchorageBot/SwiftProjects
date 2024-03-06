//
//  AppViews Group
//  WeatherView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 

/*
 Abstract:
 
 The weather view shows the garden's weather
 
 References:
 
 https://developer.apple.com/tutorials/Sample-Apps
 
 */

import SwiftUI

struct WeatherView: View {
    var body: some View {
        
        Image(systemName: "cloud")
            .imageScale(.large)
            .foregroundColor(Color.blue)
            .foregroundStyle(.tint)
        
            .padding()
        
        Text("Hello, Garden Weather!")
        
            .padding()
        
        
         
         // Attempt to link back to ContentView screen
         
         TabView {
         
         NavigationView()
         .tabItem {
         Label("Home", systemImage: "home")
         }
         }
         
        
    }
}

#Preview {
    WeatherView()
}


