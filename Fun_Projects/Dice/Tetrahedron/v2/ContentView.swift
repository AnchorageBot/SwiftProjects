//
// Tetrahedron_v2
// ContentView.swift
//
// Created on 5/1/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// ContentView is the main view of our application
// It contains the dice UI and handles the rolling logic
struct ContentView: View {
    // MARK: - Properties
    
    // State variables track the view's dynamic data
    // When these change, SwiftUI automatically updates the view
    
    // Tracks the current value shown on the dice (1-4)
    @State private var diceResult = 1
    
    // Tracks whether the dice is currently in the middle of a roll animation
    @State private var isRolling = false
    
    // Tracks the current rotation angle of the dice during animation
    @State private var rotationDegrees = 0.0
    
    // MARK: - View Body
    
    // The body property defines the view's appearance
    var body: some View {
        // VStack arranges its children vertically
        VStack {
            // Add some space at the top of the screen
            Spacer()
            
            // Title text at the top of the screen
            Text("Tetrahedron Dice")
                .font(.largeTitle)  // Use the system's large title font
                .fontWeight(.bold)  // Make the text bold
                .padding(.bottom, 30)  // Add 30 points of padding below the text
            
            // ZStack arranges its children on top of each other (z-axis)
            // This allows us to place elements in a 3D-like arrangement
            ZStack {
                // This custom view represents our tetrahedron dice
                // We pass the current result to display on the dice
                TetrahedronView(result: diceResult)
                    .frame(width: 200, height: 200)  // Set fixed dimensions
                    // Apply a 3D rotation effect during animation
                    .rotation3DEffect(
                        // Use the current rotation angle in degrees
                        .degrees(rotationDegrees),
                        // Rotate around a random axis to make it look more realistic
                        axis: (x: Double.random(in: 0...1),
                               y: Double.random(in: 0...1),
                               z: Double.random(in: 0...1))
                    )
            }
            .padding(40)  // Add padding around the tetrahedron
            
            // Display the current dice result as text
            Text("Result: \(diceResult)")
                .font(.title)  // Use the system's title font
                .fontWeight(.semibold)  // Make it semi-bold
                .padding(.top, 20)  // Add padding above the text
                .accessibilityLabel("Dice result is \(diceResult)")  // For VoiceOver support
            
            // Add flexible space to push the button to the bottom
            Spacer()
            
            // Button that triggers the dice roll animation
            Button(action: rollDice) {  // Call rollDice() when tapped
                // The button's label is a text view
                Text("Roll Dice")
                    .font(.title2)  // Use the system's second-level title font
                    .fontWeight(.bold)  // Make it bold
                    .foregroundColor(.white)  // White text
                    .padding()  // Add padding inside the button
                    .frame(width: 200)  // Fixed width
                    // Background color changes based on whether the dice is rolling
                    .background(isRolling ? Color.gray : Color.blue)
                    .cornerRadius(10)  // Rounded corners
                    .shadow(radius: 5)  // Subtle shadow for depth
            }
            // Disable the button while the dice is rolling to prevent multiple rolls
            .disabled(isRolling)
            .padding(.bottom, 50)  // Add padding below the button
            .accessibilityLabel("Roll the dice")  // For VoiceOver support
            .accessibilityHint("Generates a random number between 1 and 4")  // Extra VoiceOver info
        }
        .padding()  // Add padding around the entire VStack
    }
    
    // MARK: - Methods
    
    // This function handles the dice rolling animation and logic
    func rollDice() {
        // Prevent multiple simultaneous rolls
        guard !isRolling else { return }
        
        // Set the rolling state to true to start the animation and disable the button
        isRolling = true
        
        // Animate the rotation of the dice
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            // Add 720 degrees (two full rotations) to the current rotation
            rotationDegrees += 720.0
        }
        
        // Parameters for the roll animation
        let rollDuration = 1.0  // Total duration of the roll in seconds
        let changeInterval = 0.1  // How frequently to change the displayed number
        var timeElapsed = 0.0  // Tracker for how much time has passed
        
        // Create a timer that fires every 0.1 seconds
        // This creates the illusion of the dice tumbling by rapidly changing the number
        Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
            // Update the elapsed time
            timeElapsed += changeInterval
            
            // Randomly change the displayed number during animation
            self.diceResult = Int.random(in: 1...4)
            
            // Check if the animation should end
            if timeElapsed >= rollDuration {
                // Stop the timer
                timer.invalidate()
                
                // Set the final random result
                self.diceResult = Int.random(in: 1...4)
                
                // Reset the rolling state to re-enable the button
                self.isRolling = false
            }
        }
    }
}

// MARK: - TetrahedronView

// This view represents the visual appearance of our tetrahedron dice
struct TetrahedronView: View {
    // The current number to display on the dice face
    let result: Int
    
    // Define how the view looks
    var body: some View {
        // ZStack allows us to layer elements
        ZStack {
            // Draw the tetrahedron shape using Path
            Path { path in
                // Create a triangle shape to represent one face of the tetrahedron
                // In a real 3D app, we would use SceneKit for a true 3D shape
                path.move(to: CGPoint(x: 100, y: 20))  // Top point
                path.addLine(to: CGPoint(x: 180, y: 150))  // Bottom right
                path.addLine(to: CGPoint(x: 20, y: 150))  // Bottom left
                path.closeSubpath()  // Connect back to the start
            }
            // Fill the shape with a gradient for a more appealing look
            .fill(LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.7), .purple.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            ))
            // Add subtle shadow for depth
            .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
            
            // Display the result number on the front face of the tetrahedron
            Text("\(result)")
                .font(.system(size: 40, weight: .bold))  // Large, bold text
                .foregroundColor(.white)  // White text for contrast
                .position(x: 100, y: 90)  // Position in the center of the face
                .shadow(color: .black, radius: 1)  // Text shadow for legibility
                .accessibilityHidden(true)  // Hide from VoiceOver since we announce the result elsewhere
        }
    }
}

// MARK: - Preview

// This struct enables the SwiftUI preview in Xcode
// It's not included in the actual application binary
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Display the ContentView in the preview canvas
        ContentView()
    }
}
