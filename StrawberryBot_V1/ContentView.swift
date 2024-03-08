//
//  Main Group
//  ContentView.swift
//  StrawberryBot_V1
//
//  Created by ATS on 3/5/24
//  Xcode version 15.2
//  Last revised on 3/8/24 by ATS and Claude

/*
 Abstract:
 
 The main view that contains the majority of the app's content
 
 The content view is the welocme mat that takes the user to the navigation view
 
 References:
 
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app
 
 https://developer.apple.com/tutorials/swiftui-concepts/maintaining-the-adaptable-sizes-of-built-in-views
 
 */

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            
            // Place holder until the button code is correctly refactored
            Image(systemName: "leaf")
                .imageScale(.large)
                .foregroundColor(Color.green)
                .foregroundStyle(.tint)
            
                .padding()
            
            // Once refactored the button will take the user to the NavigationView
            Button("Let's Garden!") {
                NavigationLink {
                    NavigationView()
                } label: {
                    NavigationView()
                }

            }
            
                .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
