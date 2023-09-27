/*

 RegularTitleView.swift
 RecipesSampleApp

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/24/2023 with Swift 5.8, Xcode 14.3.1
 Updated on 9/26/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct RegularTitleView: View {

    // allows the view to read & write data to an instance of Recipe
    @Binding var recipe: Recipe

    var body: some View {

        VStack(alignment: .leading) {

            Text(recipe.title)
                .font(.largeTitle)

            /*  shares a binding to the recipe's rating property with the
                custom control StarRating which allows the control to read
                and write to that property

                The dollar sign ($) prefix on the variable name recipe indicates
                that the call is passing a binding to StarRating
            */
            StarRating(rating: $recipe.rating)
        }
        Spacer()

        Text(recipe.subtitle)
            .font(.subheadline)
    }
}
