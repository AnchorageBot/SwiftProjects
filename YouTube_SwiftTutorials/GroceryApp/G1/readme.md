# Glossary of Concepts & Terms for SwiftUI Grocery List App

## Apple Technologies and Frameworks

### [App Extensions](https://developer.apple.com/app-extensions/)
- Extend the functionality of your app to other parts of the system.

### [Design](https://developer.apple.com/design/)
- Apple's design guidelines for creating intuitive and visually appealing apps.

### [iOS](https://developer.apple.com/ios/)
- Apple's mobile operating system for iPhone and iPod Touch devices.

### [SF Symbols](https://developer.apple.com/sf-symbols/)
- A library of iconography designed to integrate seamlessly with San Francisco, the system font for Apple platforms.

### [SwiftData Framework](https://developer.apple.com/xcode/swiftdata/)
- A framework that makes it easy to persist data using declarative code. You can query and filter data using regular Swift code, and it's designed to integrate seamlessly with SwiftUI.

### [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- A modern way to declare user interfaces for any Apple platform. It provides views, controls, and layout structures for declaring your app's user interface.

### [Xcode](https://developer.apple.com/documentation/xcode)
- Apple's integrated development environment (IDE) for macOS, used to build apps for Apple platforms.

## SwiftData Concepts

### [@Model](https://developer.apple.com/documentation/swiftdata/model())
- A property wrapper that defines a model type in SwiftData, used to represent persistent data.

### [ModelContainer](https://developer.apple.com/documentation/swiftdata/modelcontainer)
- A container that holds the data stack for SwiftData, including the persistent store and schema.

### [ModelConfiguration](https://developer.apple.com/documentation/swiftdata/modelconfiguration)
- A type that describes the configuration of an app's schema or specific group of models.

### [@Query](https://developer.apple.com/documentation/swiftdata/query)
- A property wrapper that fetches model instances from the model container based on specified criteria.

### [Schema](https://developer.apple.com/documentation/swiftdata/schema)
- Defines the structure and relationships of your data models in SwiftData.

## SwiftUI Concepts

### [@Environment](https://developer.apple.com/documentation/swiftui/environment)
- A property wrapper for accessing values from the SwiftUI environment.

### [@State](https://developer.apple.com/documentation/swiftui/state)
- A property wrapper that allows a value to be stored as mutable state in a view.

### [NavigationView](https://developer.apple.com/documentation/swiftui/navigationview)
- A view that enables hierarchical navigation in your app's user interface.

### [List](https://developer.apple.com/documentation/swiftui/list)
- A container that presents rows of data arranged in a single column.

### [ForEach](https://developer.apple.com/documentation/swiftui/foreach)
- A structure that computes views on demand from an underlying collection of identified data.

## App-Specific Concepts

### GroceryListItem
- The main data model representing a single item in the grocery list. It includes properties like title, subtitle, date, and completion status.

### ContentView
- The main view of the app, responsible for displaying the list of grocery items and handling user interactions.

### formattedDate
- A computed property that returns a formatted string representation of a date.

## Swift Language Features

### @main
- An attribute that identifies the entry point of a Swift program.

### Extensions
- A Swift feature that allows you to add new functionality to an existing class, structure, enumeration, or protocol type.

### Computed Properties
- Properties that run code to determine their value, rather than storing a value directly.
