//
//  WelcomePage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/7/24
//  Made with Xcode 15.3
//

/*
Abstract:
 This code defines the WelcomePage struct, which invites the user to the app. The view is built using SwiftUI, which allows for a declarative and concise way of constructing the user interface.

References:
- SwiftUI App Life Cycle: https://developer.apple.com/documentation/swiftui/app
- SwiftUI App Protocol: https://developer.apple.com/documentation/swiftui/app
- SwiftUI WindowGroup: https://developer.apple.com/documentation/swiftui/windowgroup
- Develop in Swift Tutorials - Layout and style
    https://developer.apple.com/tutorials/develop-in-swift/design-an-interface
- Anthropic AI Claude
     https://www.anthropic.com
*/

import SwiftUI

struct WelcomePage: View {
    
    var body: some View {
        
        VStack {
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 150, height: 150)
                //.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.tint)
            
            Text("Welcome to the app!")
                //.font(Font.title)
                .font(.title)
                .fontWeight(.semibold)
                .border(.black, width: 1.5)
            
            Text("Description")
                .font(.title2)
                .border(.black, width: 1.5)
        }
        .border(.orange, width: 1.5)
        .padding()
        .border(.purple, width: 1.5)
    }
}

#Preview {
    WelcomePage()
}
