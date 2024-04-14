//
//  FeaturesPage.swift
//  OnboardingFlow
//
//  Created by ATS on 4/9/24
//  Made with Xcode 15.3
//  Revised on 4/13/24
//
//  Refactored and commented by Claude on 4/13/24
//

import SwiftUI

/// The features page view.
struct FeaturesPage: View {
    var body: some View {
        VStack {
            /// The title text for the features page.
            Text("Features")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom)
            
            /// The first feature card.
            FeaturesCard(
                iconName: "plant",
                description: "Discover beautiful plants"
            )
            
            /// The second feature card.
            FeaturesCard(
                iconName: "sun.max",
                description: "Get gardening tips"
            )
            
            Spacer()
        }
        .padding()
    }
}

/// Preview the FeaturesPage in Xcode's preview canvas.
struct FeaturesPage_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesPage()
            .frame(maxHeight: .infinity)
    }
}
