/*

 DetailView.swift
 RecipesSampleApp

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> Swift UI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 https://developer.apple.com/documentation/SwiftUI/Binding

 https://developer.apple.com/documentation/SwiftUI/State

 https://developer.apple.com/documentation/SwiftUI/StateObject

 https://developer.apple.com/documentation/swiftui/environmentobject

 https://developer.apple.com/documentation/SwiftUI/Binding/init(get:set:)-7ufcp

 https://developer.apple.com/documentation/SwiftUI/View/navigationTitle(_:)-43srq

 https://developer.apple.com/documentation/SwiftUI/Binding/wrappedValue

 Created on 9/24/2023 with Swift 5.8, Xcode 14.3.1
 Updated on 9/26/2023 with Swift 5.9, Xcode 15.0

*/

import SwiftUI

struct DetailView: View {

    // A property wrapper type that can read and write a value owned by a source of truth
    @Binding var recipeId: Recipe.ID?


    // A property wrapper type for an observable object that a parent or ancestor view supplies
    @EnvironmentObject private var recipeBox: RecipeBox

    // A property wrapper type that can read and write a value managed by SwiftUI
    @State private var showDeleteConfirmation = false

    // returns a custom Binding of type Recipe
    private var recipe: Binding<Recipe> {

        // provides read and write access to a value
        Binding {

            if let id = recipeId {
                return recipeBox.recipe(with: id) ?? Recipe.emptyRecipe()

            } else {
                return Recipe.emptyRecipe()

            }

        } set: { updatedRecipe in
            recipeBox.update(updatedRecipe)

        }
    }

    var body: some View {

        ZStack {

            if recipeBox.contains(recipeId) {

                RecipeDetailView(recipe: recipe)

                    // accepts a string value not a binding to a string value, so the view passes the recipe binding’s wrappedValue

                    .navigationTitle(recipe.wrappedValue.title)

                    #if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)

                    #endif
                    .toolbar {

                        RecipeDetailToolbar(
                            recipe: recipe,
                            showDeleteConfirmation: $showDeleteConfirmation,
                            deleteRecipe: deleteRecipe)
                    }

            } else {
                RecipeNotSelectedView()

            }
        }
    }

    private func deleteRecipe() {
        recipeBox.delete(recipe.id)
    }
}
