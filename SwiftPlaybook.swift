// Created by Anthropic's AI Claude on 8/14/2024

/**
 Abstract:
 This SwiftUI toy app demonstrates a simple task manager that incorporates various SwiftUI concepts.
 It allows users to add tasks, mark them as completed, view task details, and toggle dark mode.
 The app showcases the following SwiftUI concepts:
 1. Structs
 2. Classes
 3. Functions
 4. Views
 5. State and Binding
 6. ObservableObject
 7. Environment Objects
 8. View Modifiers
 9. Lists and Navigation
 10. Gestures
 
Each concept is implemented and explained throughout the code.

To use this app:

1. Create a new SwiftUI project in Xcode.
2. Replace the contents of your ContentView.swift file with this code.
3. Run the app in the simulator or on a device.
 */

import SwiftUI

// MARK: - Models

/**
 Concept 1: Structs
 Structs are value types used to represent simple data models.
 Here, we use a struct to define a Task with an id, title, and completion status.
 */

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

// MARK: - View Models

/**
 Concept 6: ObservableObject
 ObservableObject is a protocol that allows a class to publish its changes to observers.
 Here, we use it to create a view model that manages the list of tasks.
 */
class TaskListViewModel: ObservableObject {
    // Published property wrapper allows SwiftUI to observe changes to this property
    @Published var tasks: [Task] = []
    
    // Function to add a new task to the list
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    // Function to toggle the completion status of a task
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }
}

// MARK: - Views

/**
 Concept 4: Views
 Views are the building blocks of the user interface in SwiftUI.
 Here, we define multiple view structs to create our app's UI.
 */
struct ContentView: View {
    // StateObject creates and manages the lifecycle of an ObservableObject
    @StateObject private var viewModel = TaskListViewModel()
    // State property wrapper is used for local state management
    @State private var newTaskTitle = ""
    // EnvironmentObject allows access to shared data throughout the app
    @EnvironmentObject var appSettings: AppSettings
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task, onToggle: {
                            viewModel.toggleTaskCompletion(task: task)
                        })
                    }
                }
            }
            .navigationTitle("Task List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            viewModel.addTask(Task(title: newTaskTitle))
                            newTaskTitle = ""
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: .constant(true)) {
            VStack {
                TextField("New Task", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Toggle("Dark Mode", isOn: $appSettings.isDarkMode)
                    .padding()
            }
            .presentationDetents([.height(150)])
        }
    }
}

struct TaskRowView: View {
    let task: Task
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Text(task.title)
            Spacer()
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .onTapGesture(perform: onToggle)
        }
    }
}

struct TaskDetailView: View {
    let task: Task
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack {
            Text(task.title)
                .font(.title)
                .roundedBackground()
            
            Text("Status: \(task.isCompleted ? "Completed" : "Pending")")
                .padding()
            
            /**
             Concept 10: Gestures
             SwiftUI provides a declarative way to handle gestures.
             Here, we implement a drag gesture on a circle.
             */
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation {
                                offset = .zero
                            }
                        }
                )
        }
        .navigationTitle("Task Details")
    }
}

// MARK: - Custom View Modifier

/**
 Concept 8: View Modifiers
 Custom view modifiers allow you to encapsulate common view modifications.
 Here, we create a custom modifier for a rounded background.
 */
struct RoundedBackground: ViewModifier {
    @EnvironmentObject var appSettings: AppSettings
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(appSettings.isDarkMode ? Color.gray : Color.blue)
            .foregroundColor(appSettings.isDarkMode ? Color.white : Color.black)
            .cornerRadius(10)
    }
}

// Extension to make the custom modifier easier to use
extension View {
    func roundedBackground() -> some View {
        self.modifier(RoundedBackground())
    }
}

// MARK: - Environment Object

/**
 Concept 7: Environment Objects
 Environment objects allow you to share data throughout your app's view hierarchy.
 Here, we use it to manage the app's dark mode setting.
 */
class AppSettings: ObservableObject {
    @Published var isDarkMode = false
}

// MARK: - App Entry Point

/**
 Concept 3: Functions
 Functions are used throughout the app for various purposes.
 The main app structure is a function-like construct that returns a Scene.

@main
struct ToyApp: App {
    @StateObject private var appSettings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appSettings)
        }
    }
}
*/

/**
 Note: Concepts 5 (State and Binding) and 9 (Lists and Navigation) are used throughout the app.
 - State is used for local state management (e.g., @State private var newTaskTitle = "")
 - Binding is implied when we pass state to child views (e.g., Toggle("Dark Mode", isOn: $appSettings.isDarkMode))
 - Lists are used to display tasks in the main view
 - Navigation is implemented using NavigationView and NavigationLink
 */
