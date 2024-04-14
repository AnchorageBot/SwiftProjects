//
//  FeaturesPage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/9/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Commented by Claude on 4/13/24
//

/*
Abstract:
 This code defines the FeaturesPage view using SwiftUI. The view is responsible for displaying a list of cards that showcase the app's features.
 The view consists of a VStack that vertically stacks its child views. At the top of the VStack, a title "Features" is displayed using the Text view, styled with a title font and a semibold font weight. The title has some bottom padding to create spacing.
 Below the title, two instances of the FeaturesCard view are created, each displaying a different feature. The FeaturesCard is a custom view that takes an icon name and a description as parameters to display the feature's details.
 A Spacer is added at the bottom of the VStack to push the feature cards to the top of the screen.
 The entire VStack is padded to provide some spacing around the content.
 The #Preview code block allows for previewing the FeaturesPage in Xcode's preview canvas. The preview is set to have a maximum height of .infinity to fill the available space. There are commented-out modifiers for applying a gradient background and setting the foreground style to white, which can be uncommented if desired.
 Note: The gradientColors array is commented out, but it can be used to define a custom gradient background for the FeaturesPage if needed.

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
    
    // gradientTop and gradientBottom RGB values are created and defined in Assets

    //let gradientColors: [Color] = [

        //.gradientTop,

        //.gradientBottom

    //]

    var body: some View {

        VStack {

            // Display a title for the features page

            Text("Features")

                .font(.title)

                .fontWeight(.semibold)

                .padding(.bottom)

                //.padding(.top, 100) // Uncomment to add top padding if needed

            // Display a feature card with an icon and description

            FeaturesCard(iconName: "person.2.crop.square.stack.fill", description: "Description and image")

            // Display another feature card with a different icon and description

            FeaturesCard(iconName:"quote.bubble.fill", description: "Short summary")

            // Add a spacer to push the cards to the top of the screen

            Spacer()

        }

        .padding()
    }
}

#Preview {
    FeaturesPage()
        .frame(maxHeight: .infinity)
        //.background(Gradient(colors: gradientColors))
        //.foregroundStyle(.white)
}
