Pattern Playbook

- - - -

This playbook will cover common patterns and techniques used in the app, which can be helpful
for future reference or when expanding the app's functionality.


# Swift UI Notes App Playbook
---
## Common Programming Solutions and Patterns

### 1. Setting Up the Core Data Stack

```swift
struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NotesAppV1")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
```
This pattern sets up a shared Core Data stack that can be used throughout the app.

### 2. Fetching Data with @FetchRequest
```swift
@FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Note.createdAt, ascending: false)],
    animation: .default)
private var notes: FetchedResults<Note>
```
This pattern allows for fetching and automatically updating data from Core Data in SwiftUI views.

### 3. Creating a New Core Data Entity
```swift
let newNote = Note(context: viewContext)
newNote.id = UUID()
newNote.title = title
newNote.content = content
newNote.createdAt = Date()

do {
    try viewContext.save()
} catch {
    let nsError = error as NSError
    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
}
```
This pattern demonstrates how to create and save a new entity in Core Data.

### 4. Deleting Core Data Entities
```swift
private func deleteNotes(offsets: IndexSet) {
    withAnimation {
        offsets.map { notes[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
```
This function shows how to delete multiple entities from Core Data based on their offsets in a list.

### 5. Presenting a Modal Sheet
```swift
@State private var isAddingNote = false

// In the view body:
.sheet(isPresented: $isAddingNote) {
    AddNoteView().environment(\.managedObjectContext, viewContext)
}
```
This pattern demonstrates how to present a modal sheet in SwiftUI.

### 6. Creating a Navigation Link
```swift
NavigationLink(destination: NoteDetailView(note: note)) {
    VStack(alignment: .leading) {
        Text(note.title ?? "Untitled")
            .font(.headline)
        Text(note.content ?? "No content")
            .font(.subheadline)
            .lineLimit(1)
            .foregroundColor(.gray)
    }
}
```
This pattern shows how to create a navigation link in a List view, allowing navigation to a detail view.

### 7. Updating an Existing Core Data Entity
```swift
TextField("Title", text: Binding(
    get: { self.note.title ?? "" },
    set: { self.note.title = $0 }
))
TextEditor(text: Binding(
    get: { self.note.content ?? "" },
    set: { self.note.content = $0 }
))

// Saving changes:
do {
    try viewContext.save()
} catch {
    let nsError = error as NSError
    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
}
```
This pattern demonstrates how to bind Core Data entity properties to SwiftUI views and save changes.

### 8. Creating a Preview for SwiftUI Views
```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```
This pattern shows how to create a preview for SwiftUI views, including setting up a preview Core Data context.

### 9. Extending Core Data Entities
```swift
extension Note {
    func setSampleData() {
        id = UUID()
        title = "Sample Note"
        content = "This is a sample note content."
        createdAt = Date()
    }
}
```
This pattern demonstrates how to extend Core Data entities with additional functionality.

### 10. Setting Up the Main App Structure
```swift
@main
struct NotesAppV1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
```
This pattern shows how to set up the main app structure in SwiftUI, including injecting the Core Data context into the environment.
```
