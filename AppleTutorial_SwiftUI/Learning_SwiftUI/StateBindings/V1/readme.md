1st Draft

[State:](https://developer.apple.com/documentation/swiftui/state)  A property wrapper type that can read and write a value managed by SwiftUI.

* Use state as the single source of truth for a given value type that you store in a view hierarchy. Create a state value in an App, Scene, or View by applying the @State attribute to a property declaration and providing an initial value. Declare state as private to prevent setting it in a memberwise initializer, which can conflict with the storage management that SwiftUI provides
