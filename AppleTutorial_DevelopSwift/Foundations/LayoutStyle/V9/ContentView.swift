//
//  ContentView.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Refactored and commented by Claude on 4/13/24
//

import SwiftUI

/// The main content view of the app.
struct ContentView: View {
    /// The gradient colors for the background.
    private let gradientColors: [Color] = [.gardenGreen, .skyBlue]
    
    var body: some View {
        TabView {
            /// The welcome page tab.
            WelcomePage()
            
            /// The features page tab.
            FeaturesPage()
        }
        .background(Gradient(colors: gradientColors))
        .tabViewStyle(.page)
        .foregroundColor(.black)
    }
}

/// Preview the ContentView in Xcode's preview canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
