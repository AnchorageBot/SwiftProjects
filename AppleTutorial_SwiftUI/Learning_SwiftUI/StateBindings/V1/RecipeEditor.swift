/*

 RecipeEditor.swift
 LearnSwiftUI_V6

 How to create this file with keyboard and Xcode commands:
 Command Key (Splat) N -> iOS -> SwiftUI View

 References:
 https://developer.apple.com/tutorials/swiftui-concepts/exploring-the-structure-of-a-swiftui-app

 https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings

 https://docs.swift.org/swift-book/documentation/the-swift-programming-language/

 Created on 9/17/2023
 Made with Swift 5.8, Xcode 14.3.1

 RecipeEditor is a structure that conforms to the View protocol

*/

import SwiftUI

struct RecipeEditor: View {

    @Binding var config: RecipeEditorConfig

    var body: some View {

        NavigationStack {

            // The structure declares the binding variable config of type RecipeEditorConfig, which contains the state data that the view uses to determine its appearance
            RecipeEditorForm(config: $config)
                .toolbar {

                    ToolbarItem(placement: .principal) {
                        Text(editorTitle)
                    }

                    ToolbarItem(placement: cancelButtonPlacement) {
                        Button {
                            config.cancel()
                        } label: {
                            Text("Cancel")
                        }
                    }

                    ToolbarItem(placement: saveButtonPlacement) {
                        Button {
                            config.done()
                        } label: {
                            Text("Save")
                        }
                    }
                }

            #if os(macOS)
                .padding()
            #endif
        }
        
    }

    private var editorTitle: String {
        config.recipe.isNew ? "Add Recipe" : "Edit Recipe"
    }

    private var cancelButtonPlacement: ToolbarItemPlacement {
        #if os(macOS)
        .cancellationAction
        #else
        .navigationBarLeading
        #endif
    }

    private var saveButtonPlacement: ToolbarItemPlacement {
        #if os(macOS)
        .confirmationAction
        #else
        .navigationBarTrailing
        #endif
    }
}
