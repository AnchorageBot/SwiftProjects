A toy note taking app

- - - -

Tutor: Anthropic's AI Claude

- - - -

Expanded instructions on how to use this in a real Xcode project:

1. Create a new Xcode project:
   - Open Xcode and create a new project.
   - Choose "App" under the iOS tab.
   - Name your project (e.g., "NotesApp") and select "SwiftUI" for the interface and "CoreData" for the data model.

2. Set up the Core Data model:
   - In the project navigator, find the .xcdatamodeld file (it should be named after your project).
   - Open this file and add a new entity named "Note".
   - Add attributes to the Note entity:
     - id: UUID
     - title: String
     - content: String
     - createdAt: Date
