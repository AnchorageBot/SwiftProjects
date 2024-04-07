//
//  ContentView.swift
//  WeatherPrototype
//
//  Created by ATS on 4/6/24
//  Made with Xcode 15.3
//  Revised on 4/7/24
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        HStack {
            
            DayForecast(day: "Mon", seeSun: true, high: 50, low: 40)
            
            DayForecast(day: "Tue", seeSun: false, high: 40, low: 30)
        }
    }
}

#Preview {
    ContentView()
}

struct DayForecast: View {
    
    let day: String
    let seeSun: Bool
    let high: Int
    let low: Int
    
    var WxEmojiName: String {
        if seeSun {
            return "sun.max.fill"
        } else {
            return "cloud.snow.fill"
        }
    }
    
    var WxEmojiColor: Color {
        if seeSun {
            return Color.yellow 
        } else {
            return Color.blue
        }
    }
    
    var body: some View {
        
        VStack {
            
            Text(day)
                .font(Font.headline)
            
            Image(systemName: WxEmojiName)
                .foregroundColor(WxEmojiColor)
                //.foregroundStyle(WxEmojiColor)
                .font(Font.largeTitle)
                .padding()
            
            // to display the value of a number in a text view, which expects a String, you have to change the number into a string
            Text("High: \(high)")
                //.fontWeight(Font.Weight.semibold)
                //.fontWeight(Font.Weight.medium)
            Text("Low: \(low)")
                .fontWeight(Font.Weight.semibold)
                //.fontWeight(Font.Weight.medium)
        }
        .padding()
    }
}
