/*

 Source:
 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 */

import SwiftUI

struct RecipeEditorForm: View {

    @Binding var config: RecipeEditorConfig

    var body: some View {

        Form {
            TextField("Recipe name", text: $config.recipe.title)
            Section {
                TextField(text: $config.recipe.servings, prompt: Text("4-6")) {
                    Text("Servings")
                }
                TextField(text: $config.recipe.prepTimeAsText, prompt: Text("in seconds")) {
                    Text("Prep time")
                }
                TextField(text: $config.recipe.cookTimeAsText, prompt: Text("in seconds")) {
                    Text("Cook time")
                }
                TextField(text: $config.recipe.collectionsAsText, prompt: Text("Breakfast, Lunch, Dinner")) {
                    Text("Collections")
                }
            }
            Section("Ingredients") {
                TextEditor(text: $config.recipe.ingredients)
                    .modifier(MacSpecificModifiers())
            }
            Section("Directions") {
                TextEditor(text: $config.recipe.directions)
                    .modifier(MacSpecificModifiers())
            }
        }
    }
}

private struct MacSpecificModifiers: ViewModifier {

    func body(content: Content) -> some View {

        content

        #if os(macOS)
            .frame(height: 80)
            .border(.gray)

        #endif
    }
}
