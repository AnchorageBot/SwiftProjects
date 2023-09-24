/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct RecipeIngredientsView: View {

    let recipe: Recipe
    
    var body: some View {

        VStack {
            Text("INGREDIENTS")
                .underline()
                .padding(.bottom)

            Text(recipe.ingredients)
                .font(.caption)
                .lineSpacing(10)
        }
        .padding()
        .background(Color.secondary.colorInvert())
    }
}
