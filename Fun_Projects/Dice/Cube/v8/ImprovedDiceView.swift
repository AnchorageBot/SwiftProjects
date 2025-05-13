//
// Cubic_v8
// ImprovedDiceView.swift
//
// Created on 5/4/25 (as per original)
// Refactored to v8 on 5/12/25
// Swift Version 6.0 (or latest applicable)
//
// ATS Project
// Assisted by Anthropic's AI Claude & Google's AI Gemini
// Refactored by Gemini for enhanced 2-point perspective
//

import SwiftUI

// A fully realized 3D cube dice view with proper artistic perspective
public struct ImprovedDiceView: View {
    // The current dice value (1-6) shown on the "front" oriented face
    public let value: Int

    // Customizable dice color
    public var diceColor: Color

    // Public initializer
    public init(value: Int, diceColor: Color = Color(red: 0.9, green: 0.1, blue: 0.1)) { // Default color using standard init
        // Ensure value is always 1-6, as dice faces are 1 through 6.
        self.value = max(1, min(value, 6))
        self.diceColor = diceColor
    }

    // Size of the cube
    private let cubeSize: CGFloat = 130

    // Border settings
    private let cornerRadius: CGFloat = 16
    private let borderWidth: CGFloat = 2.5

    // Perspective configuration: Controls the intensity of the foreshortening.
    private let perspectiveEffectStrength: CGFloat = 0.35 // Smaller = more extreme, Larger = flatter

    // Static perspective angles to achieve the two-point perspective view.
    private let xAngle: Double = 20  // Tilt downward to see the top face.
    private let yAngle: Double = -35 // Rotate to see a side face.

    // Pre-calculated adjacent faces based on the primary 'value' (front face)
    private var adjacentFaces: (top: Int, right: Int) {
        StandardDie.getAdjacentFaces(frontValue: self.value)
    }

    public var body: some View {
        ZStack {
            // Inner ZStack contains the 6 faces, positioned and rotated relative to the center
            ZStack {
                // --- Dice Faces ---
                // Each face is created, then rotated into its 3D position, then offset outwards.
                // The `perspective` parameter in rotation3DEffect foreshortens faces not parallel to the view plane.
                // `zIndex` helps manage drawing order, though 3D rotation often handles this implicitly.

                // FRONT FACE: Displays the main 'value'. Centered, facing viewer.
                diceFace(value: self.value, orientation: .front)
                    // No rotation needed relative to the inner ZStack's default orientation.
                    // No offset needed as it defines the center plane (Z=0).
                    .zIndex(10) // Conceptually closest

                // BACK FACE: Opposite to the front face.
                diceFace(value: 7 - self.value, orientation: .back)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength)
                    // Rotated 180 degrees around Y-axis. Offset is handled by rotation origin (center).
                    .zIndex(0) // Conceptually furthest

                // RIGHT FACE: Shows the value to the right of the front face.
                diceFace(value: adjacentFaces.right, orientation: .right)
                    .rotation3DEffect(.degrees(90), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength) // Rotate 90 deg around Y
                    .offset(x: cubeSize / 2) // THEN offset along the parent's X-axis (which is now the face's Z-axis)
                    .zIndex(5)

                // LEFT FACE: Opposite to the right face.
                diceFace(value: 7 - adjacentFaces.right, orientation: .left)
                    .rotation3DEffect(.degrees(-90), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength) // Rotate -90 deg around Y
                    .offset(x: -cubeSize / 2) // THEN offset along the parent's X-axis
                    .zIndex(1)

                // TOP FACE: Shows the value on top of the front face.
                diceFace(value: adjacentFaces.top, orientation: .top)
                    .rotation3DEffect(.degrees(-90), axis: (x: 1, y: 0, z: 0), perspective: perspectiveEffectStrength) // Rotate -90 deg around X
                    .offset(y: -cubeSize / 2) // THEN offset along the parent's Y-axis
                    .zIndex(4)

                // BOTTOM FACE: Opposite to the top face.
                diceFace(value: 7 - adjacentFaces.top, orientation: .bottom)
                    .rotation3DEffect(.degrees(90), axis: (x: 1, y: 0, z: 0), perspective: perspectiveEffectStrength) // Rotate 90 deg around X
                    .offset(y: cubeSize / 2) // THEN offset along the parent's Y-axis
                    .zIndex(2)
            }
            // Apply the overall static viewing angle rotation to the entire cube assembly
            .rotation3DEffect(.degrees(xAngle), axis: (x: 1, y: 0, z: 0), anchor: .center)
            .rotation3DEffect(.degrees(yAngle), axis: (x: 0, y: 1, z: 0), anchor: .center)
        }
        // Apply a dynamic shadow based on the viewing angle to enhance the 3D effect
        .shadow(color: Color.black.opacity(0.45), radius: 8, x: CGFloat(yAngle / -6), y: CGFloat(xAngle / 2.5))
        // Set the frame slightly larger than the cube to accommodate perspective effects
        .frame(width: cubeSize * 1.15, height: cubeSize * 1.15)
    }

    // Enum to identify face orientation for shading purposes.
    private enum FaceOrientation {
        case front, back, top, bottom, left, right
    }

    // Creates a single face of the die with appropriate shading and pips.
    @ViewBuilder // Use ViewBuilder for cleaner conditional logic if needed later
    private func diceFace(value: Int, orientation: FaceOrientation) -> some View {
        // Determine the gradient based on orientation, simulating light from top-front-left.
        let faceGradient = Gradient(colors: [
            diceColor.brighter(by: shadeAmount(orientation, .light)), // Lighter part
            diceColor.darker(by: shadeAmount(orientation, .dark))     // Darker part
        ])

        ZStack {
            // Base face shape with gradient
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(
                    gradient: faceGradient,
                    startPoint: .topLeading, // Consistent gradient direction
                    endPoint: .bottomTrailing
                ))
                .frame(width: cubeSize, height: cubeSize)
                .overlay( // Border for the face
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.black.opacity(0.65), lineWidth: borderWidth)
                )
                .overlay( // Specular highlight, more prominent on faces angled towards the light
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white.opacity(highlightOpacity(for: orientation)))
                         // Adjust highlight shape/position
                        .frame(width: cubeSize * 0.9, height: cubeSize * 0.35)
                        .offset(y: -cubeSize * 0.22)
                        .blur(radius: 5.5)
                        .clipped() // Keep highlight within face bounds
                )

            // Add the pips (dots)
            EnhancedDicePips(value: value, size: cubeSize)
        }
    }

    // Helper to determine the opacity of the highlight based on face orientation.
    private func highlightOpacity(for orientation: FaceOrientation) -> CGFloat {
        // Based on xAngle=20, yAngle=-35 (light roughly top-front-left of the view)
        switch orientation {
        case .top: return 0.22 // Most direct highlight
        case .front: return 0.15
        case .right: return 0.12 // Visible side face gets some highlight
        default: return 0.04  // Other faces get minimal direct highlight
        }
    }

    // Enum for shading type
    private enum ShadingType { case light, dark }

    // Determines the amount to brighten or darken a face based on its orientation.
    private func shadeAmount(_ orientation: FaceOrientation, _ type: ShadingType) -> CGFloat {
        // Heuristic for shading based on assumed light direction (top-front-left relative to static view)
        switch orientation {
        case .top:    return type == .light ? 0.12 : -0.03 // Brightest
        case .front:  return type == .light ? 0.05 : 0.05  // Well-lit
        case .right:  return type == .light ? 0.00 : 0.12  // Side, slightly less direct light
        case .left:   return type == .light ? -0.08 : 0.18 // Mostly away from light
        case .bottom: return type == .light ? -0.10 : 0.22 // Mostly in shadow
        case .back:   return type == .light ? -0.15 : 0.28 // Darkest (opposite light)
        }
    }
}

// Helper struct to define standard die face relationships.
struct StandardDie {
    // Defines (Top, Right) face values when F (Front) is a given value.
    // Assumes a common "right-handed" die layout where opposite faces sum to 7.
    private static let relationships: [Int: (top: Int, right: Int)] = [
        1: (top: 5, right: 3), // If 1 is Front, 5 is Top (since 2 is Bottom), 3 is Right (since 4 is Left)
        2: (top: 1, right: 3), // If 2 is Front, 1 is Top (since 6 is Bottom), 3 is Right (since 4 is Left)
        3: (top: 5, right: 6), // If 3 is Front, 5 is Top (since 2 is Bottom), 6 is Right (since 1 is Left)
        4: (top: 5, right: 1), // If 4 is Front, 5 is Top (since 2 is Bottom), 1 is Right (since 6 is Left)
        5: (top: 6, right: 3), // If 5 is Front, 6 is Top (since 1 is Bottom), 3 is Right (since 4 is Left)
        6: (top: 2, right: 3)  // If 6 is Front, 2 is Top (since 5 is Bottom), 3 is Right (since 4 is Left)
        // Note: The top/right relationship depends on how you orient the die initially. This is one common standard.
    ]

    static func getAdjacentFaces(frontValue: Int) -> (top: Int, right: Int) {
        // Fallback for safety, though 'value' in ImprovedDiceView is clamped 1-6.
        return relationships[frontValue] ?? (top: 0, right: 0) // Should not happen
    }
}

// Extension to allow easy brightening or darkening of Colors.
// (Using UIColor bridge for HSB manipulation)
extension Color {
    func brighter(by percentage: CGFloat = 0.1) -> Color {
        return self.adjustHSB(brightness: abs(percentage))
    }

    func darker(by percentage: CGFloat = 0.1) -> Color {
        return self.adjustHSB(brightness: -abs(percentage))
    }

    // Adjusts Hue, Saturation, Brightness.
    private func adjustHSB(hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat) -> Color {
        let uiColor = UIColor(self)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0

        guard uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            print("Warning: Failed to get HSB values for color \(self). Returning original.")
            return self // Failed to get HSB, return original
        }

        // Apply adjustments, ensuring brightness stays within [0, 1]
        let newBrightness = min(max(0, b + brightness), 1)

        return Color(UIColor(hue: h + hue, // Hue/Saturation adjustments can be added if needed
                             saturation: s + saturation,
                             brightness: newBrightness,
                             alpha: a))
    }
}


// View for rendering the pips (dots) on a dice face.
// (Consider moving to its own file if complexity increases)
public struct EnhancedDicePips: View {
    public let value: Int    // The number of pips to display (1-6)
    public let size: CGFloat // The size of the dice face this sits on (i.e., cubeSize)

    public init(value: Int, size: CGFloat) {
        self.value = value
        self.size = size
    }

    // Pip size relative to the face size.
    private var pipSize: CGFloat { size * 0.16 }

    // Spacing for arranging pips, relative to face size.
    private var spacing: CGFloat { size * 0.24 }

    private let pipColor = Color.white
    private let pipShadowColor = Color.black.opacity(0.35)

    public var body: some View {
        // Use GeometryReader to get the exact size available for positioning
        GeometryReader { geometry in
            let midX = geometry.size.width / 2
            let midY = geometry.size.height / 2

            ZStack {
                // Place pips based on the dice value using calculated positions
                switch value {
                case 1:
                    enhancedPip().position(x: midX, y: midY)
                case 2:
                    enhancedPip().position(x: midX - spacing, y: midY - spacing)
                    enhancedPip().position(x: midX + spacing, y: midY + spacing)
                case 3:
                    enhancedPip().position(x: midX - spacing, y: midY - spacing)
                    enhancedPip().position(x: midX, y: midY)
                    enhancedPip().position(x: midX + spacing, y: midY + spacing)
                case 4:
                    enhancedPip().position(x: midX - spacing, y: midY - spacing)
                    enhancedPip().position(x: midX + spacing, y: midY - spacing)
                    enhancedPip().position(x: midX - spacing, y: midY + spacing)
                    enhancedPip().position(x: midX + spacing, y: midY + spacing)
                case 5:
                    enhancedPip().position(x: midX - spacing, y: midY - spacing)
                    enhancedPip().position(x: midX + spacing, y: midY - spacing)
                    enhancedPip().position(x: midX, y: midY)
                    enhancedPip().position(x: midX - spacing, y: midY + spacing)
                    enhancedPip().position(x: midX + spacing, y: midY + spacing)
                case 6:
                    // Use slightly adjusted Y offset for the 6-pip layout if needed, spacing works okay too.
                    // let yOffsetForSix = spacing // Using standard spacing often looks fine
                    enhancedPip().position(x: midX - spacing, y: midY - spacing) // Top-left
                    enhancedPip().position(x: midX + spacing, y: midY - spacing) // Top-right
                    enhancedPip().position(x: midX - spacing, y: midY)           // Middle-left
                    enhancedPip().position(x: midX + spacing, y: midY)           // Middle-right
                    enhancedPip().position(x: midX - spacing, y: midY + spacing) // Bottom-left
                    enhancedPip().position(x: midX + spacing, y: midY + spacing) // Bottom-right
                default: // Fallback for invalid values (shouldn't be reached)
                    Text("?")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(pipColor)
                        .position(x: midX, y: midY)
                }
            }
        }
         // Ensure pips respect the frame of the DiceFace's ZStack
        .frame(width: size, height: size)
    }

    // Defines the appearance of a single pip.
    @ViewBuilder
    private func enhancedPip() -> some View {
        ZStack {
            // Main pip circle with a subtle radial gradient
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [pipColor.brighter(by: 0.05), pipColor.darker(by: 0.03)]),
                        center: .center,
                        startRadius: 0,
                        endRadius: pipSize * 0.6 // Gradient extent
                    )
                )
                .frame(width: pipSize, height: pipSize)
                .shadow(color: pipShadowColor, radius: 1.8, x: 0.8, y: 0.8)

            // Small highlight spot for a glint effect
            Circle()
                .fill(Color.white.opacity(0.75))
                .frame(width: pipSize * 0.28, height: pipSize * 0.28)
                .offset(x: -pipSize * 0.21, y: -pipSize * 0.21) // Position top-left-ish
                .blur(radius: 0.35) // Minimal blur
        }
    }
}
