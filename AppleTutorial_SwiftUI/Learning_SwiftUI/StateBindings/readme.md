[Driving changes in your UI with state and bindings](https://developer.apple.com/tutorials/swiftui-concepts/driving-changes-in-your-ui-with-state-and-bindings)

Indicate data dependencies in a view using state, and share those dependencies with other views using bindings.

The user interface of a SwiftUI app is a composition of views that form a view hierarchy. Each view has a dependency
on some data. As that data changes, either due to external events or because of actions taken by a person using the app,
SwiftUI automatically updates the view to reflect those changes.

This sample shows examples of using State variables to indicate data dependencies, and sharing data with other views
using the Binding property wrapper.

- - - -

[State:](https://developer.apple.com/documentation/swiftui/state)  A property wrapper type that can read and write a value managed by SwiftUI.

* Use state as the single source of truth for a given value type that you store in a view hierarchy. Create a state value in an App, Scene, or View by applying the @State attribute to a property declaration and providing an initial value. Declare state as private to prevent setting it in a memberwise initializer, which can conflict with the storage management that SwiftUI provides

[Binding](https://developer.apple.com/documentation/swiftui/binding): A property wrapper type that can read and write a value owned by a source of truth.

* Use a binding to create a two-way connection between a property that stores data, and a view that displays and changes the data. A binding connects a property to a source of truth stored elsewhere, instead of storing data directly.

[Managing user interface state](https://developer.apple.com/documentation/swiftui/managing-user-interface-state)

* Encapsulate view-specific data within your app’s view hierarchy to make your views reusable.

- - - -

WWDC 2020 Videos

* [Data Essentials in SwiftUI](https://developer.apple.com/videos/play/wwdc2020/10040/)
