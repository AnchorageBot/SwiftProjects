/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct RecipeDirectionsView: View {

    let recipe: Recipe
    
    var body: some View {

        VStack(alignment: .leading) {

            Text("Directions")
                .font(.title3)
                .padding(.bottom)

            Text(recipe.directions)

        }
    }
}
