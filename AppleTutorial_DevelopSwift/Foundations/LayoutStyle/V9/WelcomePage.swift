//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Revised on 4/11/24
//
//  Refactored and commented by Claude on 4/13/24
//

import SwiftUI

/// The welcome page view.
struct WelcomePage: View {
    var body: some View {
        VStack {
            ZStack {
                /// The background rounded rectangle for the image.
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.leafGreen)
                
                /// The system image of a leaf.
                Image(systemName: "leaf")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            /// The welcome message text.
            Text("Welcome to the Garden App!")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            
            /// The description text.
            Text("Explore the beauty of nature")
                .font(.title2)
        }
        .padding()
    }
}

/// Preview the WelcomePage in Xcode's preview canvas.
struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
