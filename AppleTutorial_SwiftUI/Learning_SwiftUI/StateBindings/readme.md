[Driving changes in your UI with state and bindings](https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings)

Indicate data dependencies in a view using state, and share those dependencies with other views using bindings.

The user interface of a SwiftUI app is a composition of views that form a view hierarchy. Each view has a dependency
on some data. As that data changes, either due to external events or because of actions taken by a person using the app,
SwiftUI automatically updates the view to reflect those changes.

This sample shows examples of using State variables to indicate data dependencies, and sharing data with other views
using the Binding property wrapper.
