//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Chapter 8 of the tutorial

/*
Abstract:
The primary role of a content view is to display the app's data.
This code represents the app's main content view. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Managing assets with asset catalogs:
    https://developer.apple.com/documentation/xcode/managing-assets-with-asset-catalogs
- Develop in Swift Tutorials - Layout and style
    https://developer.apple.com/tutorials/develop-in-swift/design-an-interface
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI

struct ContentView: View {
    
    
    // gradientTop and gradientBottom RGB values are created and defined in Assets
    let gradientColors: [Color] = [
        .gradientTop,
        .gradientBottom
    ]
    
    var body: some View {
        
        TabView {
            
            WelcomePage()
            
            FeaturesPage()
            
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundColor(.black)
    }
}

#Preview {
    ContentView()
}
