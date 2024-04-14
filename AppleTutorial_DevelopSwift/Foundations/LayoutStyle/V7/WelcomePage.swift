//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//  Revised on 4/11/24
//
//  Commented by Claude on 4/13/24
//

/*
Abstract:
 This code defines the WelcomePage struct, which invites the user to the app. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
 - Apple Developer https://developer.apple.com/documentation/
- Develop in Swift Tutorials - Layout and style
    https://developer.apple.com/tutorials/develop-in-swift/design-an-interface
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI

struct WelcomePage: View {
    
    var body: some View {

            VStack {

                ZStack {

                    // Create a rounded rectangle background for the image

                    RoundedRectangle(cornerRadius: 30)

                        .frame(width: 150, height: 150)

                        .foregroundStyle(.tint)

                    // Display a system image of two figures holding hands

                    Image(systemName: "figure.2.and.child.holdinghands")

                        .font(.largeTitle)

                }

                // Display a welcome message

                Text("Welcome to the app!")

                    .font(.title)

                    .fontWeight(.semibold)

                    .padding(.top)

                    //.border(.black, width: 1.5) // Uncomment for debugging purposes

                // Display a description text

                Text("Description")

                    .font(.title2)

                    //.border(.black, width: 1.5) // Uncomment for debugging purposes

            }

                //.border(.orange, width: 1.5) // Uncomment for debugging purposes

                .padding()

                //.border(.purple, width: 1.5) // Uncomment for debugging purposes

        }
}

#Preview {
    WelcomePage()
}
