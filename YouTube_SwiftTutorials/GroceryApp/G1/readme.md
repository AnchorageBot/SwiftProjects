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

### [@Relationship](https://developer.apple.com/documentation/swiftdata/relationship)
- A property wrapper that defines a relationship between two model types in SwiftData.

## SwiftUI Concepts

### [@Environment](https://developer.apple.com/documentation/swiftui/environment)
- A property wrapper for accessing values from the SwiftUI environment.

### [@State](https://developer.apple.com/documentation/swiftui/state)
- A property wrapper that allows a value to be stored as mutable state in a view.

### [@Bindable](https://developer.apple.com/documentation/swiftui/bindable)
- A property wrapper type that can read and write a value owned by a source of truth.

### [NavigationView](https://developer.apple.com/documentation/swiftui/navigationview)
- A view that enables hierarchical navigation in your app's user interface.

### [List](https://developer.apple.com/documentation/swiftui/list)
- A container that presents rows of data arranged in a single column.

### [ForEach](https://developer.apple.com/documentation/swiftui/foreach)
- A structure that computes views on demand from an underlying collection of identified data.

### [GeometryReader](https://developer.apple.com/documentation/swiftui/geometryreader)
- A container view that defines its content as a function of its own size and coordinate space.

### [Form](https://developer.apple.com/documentation/swiftui/form)
- A container for grouping controls used for data entry.

### [Chart](https://developer.apple.com/documentation/charts/chart)
- A view that displays a chart using the Swift Charts framework.

## App-Specific Concepts

### GroceryListItem
- The main data model representing a single item in the grocery list. It includes properties like title, subtitle, date, completion status, and current price.

### PriceHistory
- A model representing the price history of a grocery item, including the price and the date it was recorded.

### ContentView
- The main view of the app, responsible for displaying the list of grocery items and handling user interactions.

### ItemDetailView
- A view that displays detailed information about a specific grocery item, including its price history and a chart.

### ItemRowView
- A custom view for displaying a single grocery item in the list, showing its title, subtitle, price, and completion status.

### AppStorageManager
- A class that manages user preferences using @AppStorage, allowing for persistent storage of app settings.

## Swift Language Features

### @main
- An attribute that identifies the entry point of a Swift program.

### Extensions
- A Swift feature that allows you to add new functionality to an existing class, structure, enumeration, or protocol type.

### Computed Properties
- Properties that run code to determine their value, rather than storing a value directly.

### Enumerations
- A common type for a group of related values that enables you to work with those values in a type-safe way within your code.

### Protocols
- A blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.

### Error Handling
- The process of responding to and recovering from error conditions in your program.

## Testing

### XCTest
- Apple's testing framework for writing unit tests, performance tests, and UI tests for your Xcode projects.

### Unit Testing
- A software testing method where individual units or components of the software are tested in isolation.

## Miscellaneous

### Logger
- A struct in the os framework for logging messages to the unified logging system.

### Formatting
- The process of converting values into specific string representations, often used for dates, numbers, and currencies.

### Error Handling
- Techniques for gracefully handling and reporting errors that occur during app execution.

### Data Persistence
- The ability of an application to save data so it can be restored later, even after the app has been closed and reopened.
