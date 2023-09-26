/*

 StarRating.swift
 RecipesSampleApp

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/View/body-8kl5o

 https://developer.apple.com/documentation/SwiftUI/ForEach

 https://developer.apple.com/documentation/SwiftUI/Image

 Created on 9/24/2023, updated 9/25/2023
 Made with Swift 5.8, Xcode 14.3.1

*/

import SwiftUI


// StarRating can read/write the value even though another view creates the value
struct StarRating: View {

    // variable which stores the rating of a recipe
    @Binding var rating: Int

    // private constant maxRating
    private let maxRating = 5

    // body = content & behavior of the view
    var body: some View {

        // displays items horizontally
        HStack {

            // ForEach = a structure that computes views on demand from an underlying collection of identified data
            ForEach(1..<maxRating + 1, id: \.self) { value in
                Image(systemName: "star")
                    .symbolVariant(value <= rating ? .fill : .none)
                    .foregroundColor(.accentColor)
                    .onTapGesture {

                        if value != rating {
                            rating = value

                        } else {
                            rating = 0

                        }
                    }
            }
        }
    }
}
