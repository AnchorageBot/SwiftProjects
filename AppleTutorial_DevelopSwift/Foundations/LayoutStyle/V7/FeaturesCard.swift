//
//  FeaturesCard.swift
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
 This code defines the FeaturesCard view using SwiftUI. The view represents a card that showcases a specific feature of the app.
 The FeaturesCard struct has two properties: iconName and description, which are used to customize the appearance and content of the card.
 The view consists of an HStack that horizontally stacks its child views. Inside the HStack, an Image view displays the icon using the provided iconName. The icon is styled with a large title font and has a fixed width of 50 points. It also has some trailing padding to create spacing between the icon and the description.
 Next to the icon, a Text view displays the description of the feature.
 A Spacer is added at the end of the HStack to push the content to the leading edge of the card.
 The HStack is padded to provide some spacing around the content.
 The background of the card is created using a RoundedRectangle shape with a corner radius of 12 points. The background is styled using the .tint foreground style. There are commented-out modifiers for adjusting the opacity and brightness of the background if desired.
 The entire card is styled with a white foreground style to ensure the content is visible against the background.
 The #Preview code block allows for previewing the FeaturesCard in Xcode's preview canvas, using specific values for the iconName and description properties.

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
    
    // Define properties for the icon name and description

    let iconName: String

    let description: String

    var body: some View {

        HStack {

            // Display the icon using the provided icon name

            Image(systemName: iconName)

                .font(.largeTitle)

                .frame(width: 50)

                .padding(.trailing, 10)

            // Display the description text

            Text(description)

            // Add a spacer to push the content to the leading edge

            Spacer()

        }

        .padding()

        .background {

            // Create a rounded rectangle background for the card

            RoundedRectangle(cornerRadius: 12)

                .foregroundStyle(.tint)

                //.opacity(0.25) // Uncomment to adjust the opacity of the background

                //.brightness(-0.4) // Uncomment to adjust the brightness of the background

        }

        .foregroundStyle(.white) // Set the foreground style to white
    }
}

#Preview {
    FeaturesCard(iconName: "person.2.crop.square.stack.fill", description: "Description and image")
}
