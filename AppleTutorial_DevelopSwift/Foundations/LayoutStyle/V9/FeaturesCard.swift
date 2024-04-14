//
//  FeaturesCard.swift
//  OnboardingFlow
//
//  Created by ATS on 4/9/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Refactored and commented by Claude on 4/13/24
//

import SwiftUI

/// A view representing a feature card.
struct FeaturesCard: View {
    /// The name of the icon to display.
    let iconName: String
    
    /// The description of the feature.
    let description: String
    
    var body: some View {
        HStack {
            /// The icon image.
            Image(systemName: iconName)
                .font(.largeTitle)
                .frame(width: 50)
                .padding(.trailing, 10)
                .foregroundColor(.leafGreen)
            
            /// The description text.
            Text(description)
            
            Spacer()
        }
        .padding()
        .background {
            /// The rounded rectangle background for the card.
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.sunYellow)
        }
        .foregroundColor(.black)
    }
}

/// Preview the FeaturesCard in Xcode's preview canvas.
struct FeaturesCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesCard(
            iconName: "plant",
            description: "Discover beautiful plants"
        )
    }
}
