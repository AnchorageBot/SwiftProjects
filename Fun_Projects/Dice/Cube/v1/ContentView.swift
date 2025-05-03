//
// Cubic_v1
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
    
    // Tracks the current value shown on the dice (1-6)
    @State private var diceResult = 1
    
    // Tracks whether the dice is currently in the middle of a roll animation
    @State private var isRolling = false
    
    // Tracks the current rotation angles of the dice during animation
    @State private var rotationDegreesX = 0.0
    @State private var rotationDegreesY = 0.0
    @State private var rotationDegreesZ = 0.0
    
    // MARK: - View Body
    
    // The body property defines the view's appearance
    var body: some View {
        // VStack arranges its children vertically
        VStack {
            // Add some space at the top of the screen
            Spacer()
            
            // Title text at the top of the screen
            Text("Cubic Dice")
                .font(.largeTitle)  // Use the system's large title font
                .fontWeight(.bold)  // Make the text bold
                .padding(.bottom, 30)  // Add 30 points of padding below the text
            
            // ZStack arranges its children on top of each other (z-axis)
            // This allows us to place elements in a 3D-like arrangement
            ZStack {
                // This custom view represents our cubic dice
                // We pass the current result to display on the dice
                CubeView(result: diceResult)
                    .frame(width: 200, height: 200)  // Set fixed dimensions
                    // Apply 3D rotation effects during animation
                    // We rotate on multiple axes to create a more realistic tumbling effect
                    .rotation3DEffect(
                        .degrees(rotationDegreesX),
                        axis: (x: 1, y: 0, z: 0)
                    )
                    .rotation3DEffect(
                        .degrees(rotationDegreesY),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .rotation3DEffect(
                        .degrees(rotationDegreesZ),
                        axis: (x: 0, y: 0, z: 1)
                    )
            }
            .padding(40)  // Add padding around the cube
            
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
            .accessibilityHint("Generates a random number between 1 and 6")  // Extra VoiceOver info
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
        
        // Animate the rotation of the dice on multiple axes for a realistic tumble
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            // Add random rotations to each axis
            // This creates a more natural and unpredictable tumbling motion
            rotationDegreesX += Double.random(in: 540...900) // 1.5 to 2.5 rotations
            rotationDegreesY += Double.random(in: 540...900)
            rotationDegreesZ += Double.random(in: 180...360) // 0.5 to 1 rotation
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
            // Cubes have 6 sides instead of 4 for a tetrahedron
            self.diceResult = Int.random(in: 1...6)
            
            // Check if the animation should end
            if timeElapsed >= rollDuration {
                // Stop the timer
                timer.invalidate()
                
                // Set the final random result
                self.diceResult = Int.random(in: 1...6)
                
                // Reset the rolling state to re-enable the button
                self.isRolling = false
            }
        }
    }
}

// MARK: - CubeView

// This view represents the visual appearance of our cubic dice
struct CubeView: View {
    // The current number to display on the dice face
    let result: Int
    
    // Define how the view looks
    var body: some View {
        // ZStack allows us to layer elements
        ZStack {
            // Create a simple 3D-like cube representation
            // In a real 3D app, we would use SceneKit for a true 3D shape
            
            // Main cube face (front face)
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.red.opacity(0.8), .orange.opacity(0.8)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 150, height: 150)
                .shadow(color: .black.opacity(0.5), radius: 5)
            
            // Left edge to give 3D appearance
            Path { path in
                path.move(to: CGPoint(x: 75 - 75, y: 75 - 75))
                path.addLine(to: CGPoint(x: 75 - 95, y: 75 - 55))
                path.addLine(to: CGPoint(x: 75 - 95, y: 75 + 55))
                path.addLine(to: CGPoint(x: 75 - 75, y: 75 + 75))
                path.closeSubpath()
            }
            .fill(Color.red.opacity(0.6))
            
            // Top edge to give 3D appearance
            Path { path in
                path.move(to: CGPoint(x: 75 - 75, y: 75 - 75))
                path.addLine(to: CGPoint(x: 75 - 55, y: 75 - 95))
                path.addLine(to: CGPoint(x: 75 + 55, y: 75 - 95))
                path.addLine(to: CGPoint(x: 75 + 75, y: 75 - 75))
                path.closeSubpath()
            }
            .fill(Color.red.opacity(0.7))
            
            // Add dice pips (dots) based on the current result
            // Different arrangements of dots for each possible value 1-6
            Group {
                if result == 1 {
                    // Center dot
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                } else if result == 2 {
                    // Top-left and bottom-right dots
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 + 35)
                } else if result == 3 {
                    // Top-left, center, and bottom-right dots
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 + 35)
                } else if result == 4 {
                    // Four corner dots
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 + 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 + 35)
                } else if result == 5 {
                    // Four corner dots plus center dot
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 + 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 + 35)
                } else if result == 6 {
                    // Six dots in three rows of two
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 - 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 - 35, y: 75 + 35)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 30, height: 30)
                        .position(x: 75 + 35, y: 75 + 35)
                }
            }
        }
        // Add a subtle border around the entire cube
        .overlay(
            Rectangle()
                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                .frame(width: 150, height: 150)
        )
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
