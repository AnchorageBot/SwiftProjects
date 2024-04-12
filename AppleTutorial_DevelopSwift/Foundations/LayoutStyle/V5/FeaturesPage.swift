//
//  FeaturesPage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/9/24
//  Made with Xcode 15.3
//

/*
Abstract:
 This code defines the FeaturesPage struct, which displays a list of cards describing the app’s features. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

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

struct FeaturesPage: View {
    
    var body: some View {
        
        VStack {
        
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            
            FeaturesCard(iconName: "person.2.crop.square.stack.fill", description: "Description and image")
       
            FeaturesCard(iconName:"quote.bubble.fill", description: "Description and image")
            
        }
        .padding()
    }
}

#Preview {
    FeaturesPage()
}
