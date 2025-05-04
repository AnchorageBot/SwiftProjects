//
// Cubic_v2
// ContentView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

// Import the SwiftUI framework for building the user interface
import SwiftUI

// ContentView is the main view of our application
// It defines the primary interface that users interact with
struct ContentView: View {
    // MARK: - Properties
    
    // @State properties cause the view to update when their values change
    // The private modifier restricts access to only within this struct
    
    // Tracks the current value shown on the dice (1-6)
    // Initial value is 1 when the app starts
    @State private var diceResult = 1
    
    // Tracks whether the dice is currently in the middle of a roll animation
    // Used to disable the roll button during animation
    @State private var isRolling = false
    
    // Track rotation angles for 3D animation effects
    // These values determine how the dice rotates in 3D space
    @State private var rotationDegreesX = 0.0 // Rotation around X axis
    @State private var rotationDegreesY = 0.0 // Rotation around Y axis
    @State private var rotationDegreesZ = 0.0 // Rotation around Z axis
    
    // MARK: - Body
    
    // The body property defines the view's content and layout
    // SwiftUI calls this property to render the view
    var body: some View {
        // VStack arranges its children in a vertical line
        VStack {
            // Create flexible space at the top
            // This pushes content toward the center
            Spacer()
            
            // App title displayed at the top
            Text("Cubic Dice")
                .font(.largeTitle) // Use the system's large title font size
                .fontWeight(.bold) // Make the text bold for emphasis
                .padding(.bottom, 30) // Add 30 points of padding below the text
            
            // ZStack arranges views along the z-axis (depth)
            // Items added first appear at the back, later items in front
            ZStack {
                // CubeView is our custom view that draws the 3D dice
                // We pass in the current result to display
                CubeView(result: diceResult)
                    .frame(width: 200, height: 200) // Set a fixed size
                    // Apply 3D rotation effects to make the dice appear to tumble
                    // The first rotation is around the X axis (horizontal)
                    .rotation3DEffect(
                        .degrees(rotationDegreesX), // Use the state property for animation
                        axis: (x: 1, y: 0, z: 0) // Rotate around X axis only
                    )
                    // The second rotation is around the Y axis (vertical)
                    .rotation3DEffect(
                        .degrees(rotationDegreesY), // Use the state property for animation
                        axis: (x: 0, y: 1, z: 0) // Rotate around Y axis only
                    )
                    // The third rotation is around the Z axis (perpendicular to screen)
                    .rotation3DEffect(
                        .degrees(rotationDegreesZ), // Use the state property for animation
                        axis: (x: 0, y: 0, z: 1) // Rotate around Z axis only
                    )
            }
            .padding(40) // Add padding around the entire dice view
            
            // Display the current dice result as text
            Text("Result: \(diceResult)")
                .font(.title) // Use the system's title font size
                .fontWeight(.semibold) // Semi-bold weight for readability
                .padding(.top, 20) // Add padding above the text
                .accessibilityLabel("Dice result is \(diceResult)") // For VoiceOver support
            
            // Create flexible space to push the button toward the bottom
            Spacer()
            
            // Button that triggers the dice roll when tapped
            Button(action: rollDice) { // Call rollDice() function when tapped
                // The button's visual appearance
                Text("Roll Dice")
                    .font(.title2) // Use the second-level title font size
                    .fontWeight(.bold) // Bold text for emphasis
                    .foregroundColor(.white) // White text for contrast
                    .padding() // Add padding inside the button
                    .frame(width: 200) // Set a fixed width
                    // Change background color based on dice state
                    .background(isRolling ? Color.gray : Color.blue)
                    .cornerRadius(10) // Round the corners
                    .shadow(radius: 5) // Add a subtle shadow for depth
            }
            // Disable the button while the dice is rolling
            // This prevents multiple simultaneous rolls
            .disabled(isRolling)
            .padding(.bottom, 50) // Add padding below the button
            .accessibilityLabel("Roll the dice") // VoiceOver label
            .accessibilityHint("Generates a random number between 1 and 6") // VoiceOver hint
        }
        .padding() // Add padding around the entire VStack
    }
    
    // MARK: - Methods
    
    // This function handles the dice rolling logic and animation
    // It's called when the user taps the roll button
    func rollDice() {
        // Guard statement prevents multiple simultaneous rolls
        // Returns early if the dice is already rolling
        guard !isRolling else { return }
        
        // Set the rolling state to true
        // This disables the button during animation
        isRolling = true
        
        // Create animation for the dice rotation
        // easeInOut provides a smooth acceleration and deceleration
        withAnimation(Animation.easeInOut(duration: 1.0)) {
            // Add random rotations to each axis for a realistic tumbling effect
            // The ranges ensure multiple rotations for a good visual effect
            rotationDegreesX += Double.random(in: 540...900) // 1.5 to 2.5 rotations on X
            rotationDegreesY += Double.random(in: 540...900) // 1.5 to 2.5 rotations on Y
            rotationDegreesZ += Double.random(in: 180...360) // 0.5 to 1 rotation on Z
        }
        
        // Configure parameters for the rolling animation
        let rollDuration = 1.0 // Total animation time in seconds
        let changeInterval = 0.1 // How often to change the displayed number
        var timeElapsed = 0.0 // Tracks elapsed time during animation
        
        // Create a timer that fires repeatedly during the animation
        // This creates the illusion of the dice tumbling through different values
        Timer.scheduledTimer(withTimeInterval: changeInterval, repeats: true) { timer in
            // Increment the elapsed time counter
            timeElapsed += changeInterval
            
            // Randomly change the displayed value during animation
            // This simulates the dice tumbling through different values
            self.diceResult = Int.random(in: 1...6)
            
            // Check if the animation should end
            if timeElapsed >= rollDuration {
                // Stop the timer when the animation is complete
                timer.invalidate()
                
                // Set the final random result (1-6)
                self.diceResult = Int.random(in: 1...6)
                
                // Reset the rolling state to re-enable the button
                self.isRolling = false
            }
        }
    }
}

// MARK: - CubeView

// CubeView is a custom view that draws a 3D-like dice cube
// It renders a cube with the appropriate number of pips (dots)
struct CubeView: View {
    // The result to display on the dice (1-6)
    // This is passed in from ContentView
    let result: Int
    
    // The body property defines the view's appearance
    var body: some View {
        // ZStack allows layering elements to create a 3D effect
        ZStack {
            // We build a 3D cube using multiple rectangles and transforms
            
            // FRONT FACE - this is the main visible face with the pips
            ZStack {
                // Front face background with gradient for visual appeal
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red.opacity(0.9), .orange.opacity(0.8)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120) // Set the size of the front face
                    .shadow(color: .black.opacity(0.3), radius: 2) // Subtle shadow for depth
                
                // Add the appropriate pip pattern based on the current result
                pipPattern(for: result)
            }
            
            // TOP FACE - creates the illusion of seeing the top of the cube
            ZStack {
                // Top face with a slightly different gradient
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red.opacity(0.7), .orange.opacity(0.6)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 120, height: 40) // Shorter height for perspective
                    // Apply transform to create a 3D perspective effect
                    // This makes the rectangle appear to recede into the distance
                    .transformEffect(
                        CGAffineTransform(a: 1, b: 0, c: 0, d: 0.5, tx: 0, ty: -60)
                    )
            }
            
            // RIGHT FACE - creates the illusion of seeing the right side of the cube
            ZStack {
                // Right face with a third gradient variation
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [.red.opacity(0.6), .orange.opacity(0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 40, height: 120) // Narrower width for perspective
                    // Apply transform to create a 3D perspective effect
                    // This makes the rectangle appear to recede into the distance
                    .transformEffect(
                        CGAffineTransform(a: 0.5, b: 0, c: 0, d: 1, tx: 60, ty: 0)
                    )
            }
            
            // BORDERS - add borders to enhance the 3D effect
            
            // Border for the front face
            Rectangle()
                .stroke(Color.black.opacity(0.8), lineWidth: 1.5) // Semi-transparent black line
                .frame(width: 120, height: 120) // Match front face dimensions
            
            // Border for the top face using a custom path
            Path { path in
                // Draw the four lines of the top face border
                path.move(to: CGPoint(x: -60, y: -60)) // Start at top-left
                path.addLine(to: CGPoint(x: 60, y: -60)) // Draw to top-right
                path.addLine(to: CGPoint(x: 60 + 20, y: -60 - 20)) // Draw to back-right
                path.addLine(to: CGPoint(x: -60 + 20, y: -60 - 20)) // Draw to back-left
                path.closeSubpath() // Connect back to start
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 1.5) // Semi-transparent black line
            .offset(x: 0, y: 0) // Center in the view
            
            // Border for the right face using a custom path
            Path { path in
                // Draw the four lines of the right face border
                path.move(to: CGPoint(x: 60, y: -60)) // Start at top-front
                path.addLine(to: CGPoint(x: 60, y: 60)) // Draw to bottom-front
                path.addLine(to: CGPoint(x: 60 + 20, y: 60 - 20)) // Draw to bottom-back
                path.addLine(to: CGPoint(x: 60 + 20, y: -60 - 20)) // Draw to top-back
                path.closeSubpath() // Connect back to start
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 1.5) // Semi-transparent black line
            .offset(x: 0, y: 0) // Center in the view
        }
        .frame(width: 150, height: 150) // Set overall frame for the cube
    }
    
    // Helper function to create the appropriate pip pattern based on dice value
    // @ViewBuilder allows returning different view types conditionally
    @ViewBuilder
    private func pipPattern(for value: Int) -> some View {
        // Switch based on the dice value (1-6)
        switch value {
        case 1:
            // For value 1: Single center pip
            pip(at: CGPoint(x: 0, y: 0)) // Place dot in center
            
        case 2:
            // For value 2: Diagonal pips - top-left and bottom-right
            VStack {
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Top-left pip
                    Spacer() // Push to left side
                }
                Spacer() // Push to top
                HStack {
                    Spacer() // Push to right side
                    pip(at: CGPoint(x: 0, y: 0)) // Bottom-right pip
                }
            }
            .padding(25) // Add padding for proper positioning
            .frame(width: 120, height: 120) // Match front face size
            
        case 3:
            // For value 3: Diagonal pips plus center - top-left, center, bottom-right
            ZStack {
                // Diagonal pips (same as for value 2)
                VStack {
                    HStack {
                        pip(at: CGPoint(x: 0, y: 0)) // Top-left pip
                        Spacer() // Push to left side
                    }
                    Spacer() // Push to top
                    HStack {
                        Spacer() // Push to right side
                        pip(at: CGPoint(x: 0, y: 0)) // Bottom-right pip
                    }
                }
                .padding(25) // Add padding for proper positioning
                .frame(width: 120, height: 120) // Match front face size
                
                pip(at: CGPoint(x: 0, y: 0)) // Center pip
            }
            
        case 4:
            // For value 4: Four corner pips
            VStack {
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Top-left pip
                    Spacer() // Space between pips
                    pip(at: CGPoint(x: 0, y: 0)) // Top-right pip
                }
                Spacer() // Space between rows
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Bottom-left pip
                    Spacer() // Space between pips
                    pip(at: CGPoint(x: 0, y: 0)) // Bottom-right pip
                }
            }
            .padding(25) // Add padding for proper positioning
            .frame(width: 120, height: 120) // Match front face size
            
        case 5:
            // For value 5: Four corner pips plus center
            ZStack {
                // Four corner pips (same as for value 4)
                VStack {
                    HStack {
                        pip(at: CGPoint(x: 0, y: 0)) // Top-left pip
                        Spacer() // Space between pips
                        pip(at: CGPoint(x: 0, y: 0)) // Top-right pip
                    }
                    Spacer() // Space between rows
                    HStack {
                        pip(at: CGPoint(x: 0, y: 0)) // Bottom-left pip
                        Spacer() // Space between pips
                        pip(at: CGPoint(x: 0, y: 0)) // Bottom-right pip
                    }
                }
                .padding(25) // Add padding for proper positioning
                .frame(width: 120, height: 120) // Match front face size
                
                pip(at: CGPoint(x: 0, y: 0)) // Center pip
            }
            
        case 6:
            // For value 6: Six pips in three rows of two
            VStack {
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Top-left pip
                    Spacer() // Space between pips
                    pip(at: CGPoint(x: 0, y: 0)) // Top-right pip
                }
                Spacer() // Space between rows
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Middle-left pip
                    Spacer() // Space between pips
                    pip(at: CGPoint(x: 0, y: 0)) // Middle-right pip
                }
                Spacer() // Space between rows
                HStack {
                    pip(at: CGPoint(x: 0, y: 0)) // Bottom-left pip
                    Spacer() // Space between pips
                    pip(at: CGPoint(x: 0, y: 0)) // Bottom-right pip
                }
            }
            .padding(20) // Slightly less padding to fit all three rows
            .frame(width: 120, height: 120) // Match front face size
            
        default:
            // For any unexpected values, fall back to displaying the number
            Text("\(value)")
                .font(.system(size: 40, weight: .bold)) // Large bold text
                .foregroundColor(.white) // White for visibility
        }
    }
    
    // Helper function to create a single pip (dot)
    // This ensures consistent pip appearance throughout the dice
    private func pip(at position: CGPoint) -> some View {
        Circle() // Use a circle shape for the pip
            .fill(Color.white) // White fill for contrast against the red/orange background
            .frame(width: 20, height: 20) // Set pip size
            .shadow(color: .black.opacity(0.5), radius: 1) // Subtle shadow for depth
            .offset(x: position.x, y: position.y) // Allow positioning with offset
    }
}
