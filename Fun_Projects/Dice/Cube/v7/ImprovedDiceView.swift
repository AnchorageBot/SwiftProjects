//
// Cubic_v7
// ImprovedDiceView.swift
//
// Created on 5/4/25 (as per original)
// Swift Version 6.0 (as per original)
//
// ATS Project
// Assisted by Anthropic's AI Claude
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
    public init(value: Int, diceColor: Color = Color(red: 0.9, green: 0.1, blue: 0.1, alpha: 1)) {
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
    // Smaller values (e.g., 0.2) create more extreme perspective; larger values (e.g., 0.8) make it flatter.
    // Original was 0.3. A slight increase can sometimes make it feel more solid.
    private let perspectiveEffectStrength: CGFloat = 0.35
    
    // Static perspective angles to achieve the two-point perspective view.
    // These angles determine the "camera" position relative to the die.
    private let xAngle: Double = 20   // Tilt downward to see the top face. (Original: 15)
    private let yAngle: Double = -35  // Rotate to see a side face. (Original: -30)
    
    // Pre-calculated adjacent faces based on the primary 'value' (front face)
    // This uses a helper struct to define standard die face relationships.
    private var adjacentFaces: (top: Int, right: Int) {
        StandardDie.getAdjacentFaces(frontValue: self.value)
    }

    // Inside public struct ImprovedDiceView: View

    public var body: some View {
        ZStack {
            ZStack {
                // FRONT FACE: Displays the main 'value'.
                diceFace(value: self.value, orientation: .front)
                    // No offset needed in X or Y for the front face if it's centered.
                    // The "forward" position is implied by its lack of Z-axis rotation away from the viewer.
                    .zIndex(10) // Highest zIndex for the face conceptually "closest"

                // BACK FACE: Opposite to the front face.
                diceFace(value: 7 - self.value, orientation: .back)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength)
                    // No explicit X, Y, or Z offset needed here if rotations place it correctly.
                    // The rotation makes it face away and appear at the "back".
                    .zIndex(0)

                // RIGHT FACE: Shows the value to the right of the front face.
                diceFace(value: adjacentFaces.right, orientation: .right)
                    .rotation3DEffect(.degrees(90), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength)
                    .offset(x: cubeSize / 2) // Correct: Position face to the right after rotation
                    .zIndex(5)

                // LEFT FACE: Opposite to the right face.
                diceFace(value: 7 - adjacentFaces.right, orientation: .left)
                    .rotation3DEffect(.degrees(-90), axis: (x: 0, y: 1, z: 0), perspective: perspectiveEffectStrength)
                    .offset(x: -cubeSize / 2) // Correct: Position face to the left after rotation
                    .zIndex(1)

                // TOP FACE: Shows the value on top of the front face.
                diceFace(value: adjacentFaces.top, orientation: .top)
                    .rotation3DEffect(.degrees(-90), axis: (x: 1, y: 0, z: 0), perspective: perspectiveEffectStrength)
                    .offset(y: -cubeSize / 2) // Correct: Position face at the top after rotation
                    .zIndex(4)

                // BOTTOM FACE: Opposite to the top face.
                diceFace(value: 7 - adjacentFaces.top, orientation: .bottom)
                    .rotation3DEffect(.degrees(90), axis: (x: 1, y: 0, z: 0), perspective: perspectiveEffectStrength)
                    .offset(y: cubeSize / 2) // Correct: Position face at the bottom after rotation
                    .zIndex(2)
            }
            .rotation3DEffect(.degrees(xAngle), axis: (x: 1, y: 0, z: 0), anchor: .center)
            .rotation3DEffect(.degrees(yAngle), axis: (x: 0, y: 1, z: 0), anchor: .center)
        }
        .shadow(color: Color.black.opacity(0.45), radius: 8, x: CGFloat(yAngle / -6), y: CGFloat(xAngle / 2.5))
        .frame(width: cubeSize * 1.15, height: cubeSize * 1.15)
    }
    
    // Enum to identify face orientation for shading purposes.
    private enum FaceOrientation {
        case front, back, top, bottom, left, right
    }

    // Creates a single face of the die with appropriate shading and pips.
    private func diceFace(value: Int, orientation: FaceOrientation) -> some View {
        // Determine the gradient for the face based on its orientation,
        // simulating light from a top-front-left direction relative to the static view.
        let faceGradient = Gradient(colors: [
            diceColor.brighter(by: shadeAmount(orientation, .light)), // Lighter part of the gradient
            diceColor.darker(by: shadeAmount(orientation, .dark))    // Darker part
        ])
        
        return ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(LinearGradient(
                    gradient: faceGradient,
                    startPoint: .topLeading, // Consistent gradient direction for all faces
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
                        .frame(width: cubeSize * 0.9, height: cubeSize * 0.35)
                        .offset(y: -cubeSize * 0.22)
                        .blur(radius: 5.5)
                        .clipped() // Ensure highlight stays within the face bounds
                )
            
            EnhancedDicePips(value: value, size: cubeSize)
        }
    }

    // Helper to determine the opacity of the highlight based on face orientation.
    private func highlightOpacity(for orientation: FaceOrientation) -> CGFloat {
        // Based on xAngle=20, yAngle=-35 (light roughly top-front-left of the view)
        switch orientation {
        case .top: return 0.22 // Most direct highlight
        case .front: return 0.15
        case .right: return 0.12 // Visible side face
        default: return 0.04   // Other faces get minimal or no direct highlight
        }
    }
    
    // Enum for shading type
    private enum ShadingType { case light, dark }

    // Determines the amount to brighten or darken a face based on its orientation.
    private func shadeAmount(_ orientation: FaceOrientation, _ type: ShadingType) -> CGFloat {
        // Heuristic for shading based on assumed light direction (top-front-left for this view)
        // Positive values brighten (for .light) or darken less (for .dark)
        // Negative values darken (for .light) or darken more (for .dark)
        switch orientation {
        case .top: // Brightest
            return type == .light ? 0.12 : -0.03
        case .front: // Well-lit
            return type == .light ? 0.05 : 0.05
        case .right: // Side, slightly shadowed from direct front light
            return type == .light ? 0.0 : 0.12
        case .left: // Mostly in shadow
            return type == .light ? -0.08 : 0.18
        case .bottom: // Mostly in shadow
            return type == .light ? -0.10 : 0.22
        case .back: // Darkest
            return type == .light ? -0.15 : 0.28
        }
    }
}

// Helper struct to define standard die face relationships.
// This ensures that the faces shown are consistent with a real die.
struct StandardDie {
    // Defines (Top, Right) face values when F (Front) is a given value.
    // This specific mapping assumes a common "right-handed" die layout.
    // Example: If 1 is Front, 5 is Top, and 3 is Right.
    private static let relationships: [Int: (top: Int, right: Int)] = [
        1: (top: 5, right: 3),
        2: (top: 1, right: 3), // If 2 is Front, 1 is Top, 3 is Right
        3: (top: 5, right: 6), // If 3 is Front, 5 is Top, 6 is Right
        4: (top: 5, right: 1), // If 4 is Front, 5 is Top, 1 is Right
        5: (top: 6, right: 3), // If 5 is Front, 6 is Top, 3 is Right
        6: (top: 2, right: 3)  // If 6 is Front, 2 is Top, 3 is Right
    ]
    
    static func getAdjacentFaces(frontValue: Int) -> (top: Int, right: Int) {
        // Fallback for safety, though 'value' in ImprovedDiceView is clamped 1-6.
        return relationships[frontValue] ?? (top: 0, right: 0)
    }
}

// Extension to allow easy brightening or darkening of Colors.
extension Color {
    func brighter(by percentage: CGFloat = 0.1) -> Color {
        return self.adjustHSB(brightness: abs(percentage))
    }

    func darker(by percentage: CGFloat = 0.1) -> Color {
        return self.adjustHSB(brightness: -abs(percentage))
    }

    // Adjusts Hue, Saturation, Brightness. For this, we only modify brightness.
    private func adjustHSB(hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat) -> Color {
        let uiColor = UIColor(self)
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        guard uiColor.getHue(&h, saturation: &s, brightness: &b, alpha: &a) else {
            return self // Failed to get HSB, return original
        }
        
        return Color(UIColor(hue: h + hue,
                             saturation: s + saturation,
                             brightness: min(max(0, b + brightness), 1), // Clamp brightness 0-1
                             alpha: a))
    }
}


// View for rendering the pips (dots) on a dice face.
public struct EnhancedDicePips: View {
    public let value: Int    // The number of pips to display (1-6)
    public let size: CGFloat // The size of the dice face this sits on (i.e., cubeSize)
    
    public init(value: Int, size: CGFloat) {
        self.value = value
        self.size = size
    }
    
    // Pip size relative to the face size.
    private var pipSize: CGFloat { size * 0.16 } // Original: 0.17, tweaked
    
    // Spacing for arranging pips, relative to face size.
    private var spacing: CGFloat { size * 0.24 } // Original: 0.22, tweaked
    
    private let pipColor = Color.white
    private let pipShadowColor = Color.black.opacity(0.35) // Original: 0.3

    public var body: some View {
        GeometryReader { geometry in // geometry.size will be equal to `size` (cubeSize)
            ZStack {
                switch value {
                case 1:
                    enhancedPip().position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                case 2:
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 + spacing)
                case 3:
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 + spacing)
                case 4:
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 + spacing)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 + spacing)
                case 5:
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 - spacing)
                    enhancedPip().position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 + spacing)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 + spacing)
                case 6:
                    // Adjusted y-spacing for 6 pips for better visual balance.
                    let yOffsetForSix = spacing * 1.0 // Original used 1.1, this makes rows more distinct
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 - yOffsetForSix)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 - yOffsetForSix)
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2)
                    enhancedPip().position(x: geometry.size.width / 2 - spacing, y: geometry.size.height / 2 + yOffsetForSix)
                    enhancedPip().position(x: geometry.size.width / 2 + spacing, y: geometry.size.height / 2 + yOffsetForSix)
                default: // Fallback, should not be reached if 'value' is 1-6
                    Text("\(value)")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(pipColor)
                }
            }
        }
    }
    
    // Defines the appearance of a single pip.
    private func enhancedPip() -> some View {
        ZStack {
            // Main pip circle with a subtle radial gradient for a rounded effect.
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [pipColor.brighter(by: 0.05), pipColor.darker(by: 0.03)]),
                        center: .center, // Gradient centered for uniform appearance
                        startRadius: 0,
                        endRadius: pipSize * 0.6 // Extent of the gradient
                    )
                )
                .frame(width: pipSize, height: pipSize)
                .shadow(color: pipShadowColor, radius: 1.8, x: 0.8, y: 0.8) // Slightly adjusted shadow

            // Inner shadow for a slight indented look (optional).
            // Circle()
            //     .stroke(Color.black.opacity(0.08), lineWidth: 0.8)
            //     .frame(width: pipSize * 0.88, height: pipSize * 0.88)
            
            // Small highlight spot to give a 3D glint.
            Circle()
                .fill(Color.white.opacity(0.75)) // Slightly more pronounced highlight
                .frame(width: pipSize * 0.28, height: pipSize * 0.28) // Adjusted size
                .offset(x: -pipSize * 0.21, y: -pipSize * 0.21) // Consistent offset
                .blur(radius: 0.35) // Minimal blur for a crisper highlight
        }
    }
}
