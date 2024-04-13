//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Commented by Claude on 4/13/24
//

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
    
    // Define an array of gradient colors using custom colors from the asset catalog
    
    // gradientTop and gradientBottom RGB values are created and defined in Assets
    
    let gradientColors: [Color] = [
        
        .gradientTop,
        
            .gradientBottom
        
    ]
    
    var body: some View {
        
        // Create a TabView to display multiple pages
        
        TabView {
            
            // Add the WelcomePage view as the first tab
            
            WelcomePage()
            
            // Add the FeaturesPage view as the second tab
            
            FeaturesPage()
            
        }
        
        // Apply a gradient background to the TabView using the defined gradientColors
        
        .background(Gradient(colors: gradientColors))
        
        // Set the tab view style to .page, which allows swiping between pages
        
        .tabViewStyle(.page)
        
        // Set the foreground color of the text to black
        
        .foregroundColor(.black)
    }
}

#Preview {
    ContentView()
}
