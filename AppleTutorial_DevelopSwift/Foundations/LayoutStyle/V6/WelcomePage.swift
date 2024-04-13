//
//  FeaturesCard.swift
//  OnboardingFlow
//
//  Created by ATS on 4/9/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Chapter 8 of the tutorial

/*
Abstract:
 This code defines the FeaturesCard struct, which defines a list of cards describing the app’s features. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

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

struct FeaturesCard: View {
    
    let iconName: String
    let description: String
    
    var body: some View {
        
        HStack {
            
            Image(systemName: iconName)
                .font(.largeTitle)
                .frame(width: 50)
                .padding(.trailing, 10)
            
            Text(description)
            
            Spacer()
            
        }
        .padding()
        .background {
            
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.tint)
            //.opacity(0.25)
            //.brightness(-0.4)
    }
    .foregroundStyle(.white)
    }
}

#Preview {
    FeaturesCard(iconName: "person.2.crop.square.stack.fill", description: "Description and image")
}
