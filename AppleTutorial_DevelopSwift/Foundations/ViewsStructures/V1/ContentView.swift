//
//  ContentView.swift
//  WeatherPrototype
//
//  Created by ATS on 4/6/24
//  Made with Xcode 15.3
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        HStack {
            
            DayForecast()
            
            VStack {
                
                Text("Tues")
                Image(systemName: "cloud.rain.fill")
                //.foregroundColor(.yellow)
                    .foregroundStyle(Color.blue)
                    .padding()
                
                Text("High 55")
                Text("Low 45")
                
            }
            .padding()
            
            VStack {
                
                Text("Wed")
                Image(systemName: "cloud.snow.fill")
                //.foregroundColor(.yellow)
                    .foregroundStyle(Color.blue)
                    .padding()
                
                Text("High 45")
                Text("Low 32")
                
            }
            .padding()
            
            
        }
    }
}

#Preview {
    ContentView()
}

struct DayForecast: View {
    
    var body: some View {
        
        VStack {
            
            Text("Mon")
            Image(systemName: "sun.max.fill")
            //.foregroundColor(.yellow)
                .foregroundStyle(Color.yellow)
                .padding()
            
            Text("High 60")
            Text("Low 50")
            
        }
        .padding()
    }
}
