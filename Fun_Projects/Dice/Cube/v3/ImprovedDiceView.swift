//
// Cubic_v3
// ImprovedDiceView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// A significantly improved 3D dice view
struct ImprovedDiceView: View {
    // The current dice value (1-6)
    let value: Int
    
    // Define the view's appearance
    var body: some View {
        // Use Z-stacking to create 3D effect
        ZStack {
            // Complete 3D dice using custom cube views
            CubeFace(.front, value: value)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 0)
            
            CubeFace(.top)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 0)
            
            CubeFace(.right)
                .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 0)
        }
        .frame(width: 150, height: 150)
    }
}

// Enum to define the different cube faces
enum CubeFaceType {
    case front, top, right
}

// A reusable view for each cube face
struct CubeFace: View {
    // The type of face (front, top, right)
    let faceType: CubeFaceType
    
    // Optional value for pip display (only needed for front face)
    let value: Int
    
    // Initialize with a face type and optional value
    init(_ faceType: CubeFaceType, value: Int = 1) {
        self.faceType = faceType
        self.value = value
    }
    
    // Base size of the cube face
    private let faceSize: CGFloat = 120
    
    // Colors for different faces to create depth
    private var faceColor: Color {
        switch faceType {
        case .front: return Color.red
        case .top: return Color.red.opacity(0.8)
        case .right: return Color.red.opacity(0.6)
        }
    }
    
    // Define the view's appearance
    var body: some View {
        // Determine the 3D transformation based on face type
        Group {
            switch faceType {
            case .front:
                // Front face with pips
                ZStack {
                    // Background of the face
                    RoundedRectangle(cornerRadius: 12)
                        .fill(faceColor)
                        .frame(width: faceSize, height: faceSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    
                    // Pips (dots) pattern
                    pipsPattern()
                }
                
            case .top:
                // Top face (no pips)
                RoundedRectangle(cornerRadius: 12)
                    .fill(faceColor)
                    .frame(width: faceSize, height: faceSize/2.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    // Transform to create perspective
                    .rotation3DEffect(
                        .degrees(-60),
                        axis: (x: 1, y: 0, z: 0),
                        anchor: .bottom
                    )
                    .offset(y: -faceSize/2.8) // Position at top
                
            case .right:
                // Right face (no pips)
                RoundedRectangle(cornerRadius: 12)
                    .fill(faceColor)
                    .frame(width: faceSize/2.5, height: faceSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    // Transform to create perspective
                    .rotation3DEffect(
                        .degrees(60),
                        axis: (x: 0, y: 1, z: 0),
                        anchor: .leading
                    )
                    .offset(x: faceSize/2.8) // Position at right
            }
        }
    }
    
    // Function to create the appropriate pip pattern
    @ViewBuilder
    private func pipsPattern() -> some View {
        switch value {
        case 1:
            // Single pip in center
            pip(at: .center)
            
        case 2:
            // Two pips on diagonal corners
            VStack {
                HStack {
                    pip(at: .topLeading)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    pip(at: .bottomTrailing)
                }
            }
            .padding(25)
            .frame(width: faceSize, height: faceSize)
            
        case 3:
            // Three pips on diagonal + center
            ZStack {
                pip(at: .center)
                
                VStack {
                    HStack {
                        pip(at: .topLeading)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        pip(at: .bottomTrailing)
                    }
                }
                .padding(25)
                .frame(width: faceSize, height: faceSize)
            }
            
        case 4:
            // Four pips in corners
            VStack {
                HStack {
                    pip(at: .topLeading)
                    Spacer()
                    pip(at: .topTrailing)
                }
                Spacer()
                HStack {
                    pip(at: .bottomLeading)
                    Spacer()
                    pip(at: .bottomTrailing)
                }
            }
            .padding(25)
            .frame(width: faceSize, height: faceSize)
            
        case 5:
            // Five pips (4 corners + center)
            ZStack {
                pip(at: .center)
                
                VStack {
                    HStack {
                        pip(at: .topLeading)
                        Spacer()
                        pip(at: .topTrailing)
                    }
                    Spacer()
                    HStack {
                        pip(at: .bottomLeading)
                        Spacer()
                        pip(at: .bottomTrailing)
                    }
                }
                .padding(25)
                .frame(width: faceSize, height: faceSize)
            }
            
        case 6:
            // Six pips (3 rows of 2)
            VStack {
                HStack {
                    pip(at: .topLeading)
                    Spacer()
                    pip(at: .topTrailing)
                }
                Spacer()
                HStack {
                    pip(at: .leading)
                    Spacer()
                    pip(at: .trailing)
                }
                Spacer()
                HStack {
                    pip(at: .bottomLeading)
                    Spacer()
                    pip(at: .bottomTrailing)
                }
            }
            .padding(25)
            .frame(width: faceSize, height: faceSize)
            
        default:
            // Fallback for unexpected values
            Text("\(value)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
    
    // Function to create a single pip (dot)
    private func pip(at position: UnitPoint) -> some View {
        Circle()
            .fill(Color.white)
            .frame(width: 18, height: 18)
            .shadow(color: .black.opacity(0.5), radius: 1, x: 0, y: 1)
            // Only apply specific positioning if not center
            .position(
                x: pipXPosition(for: position),
                y: pipYPosition(for: position)
            )
    }
    
    // Helper to calculate X position for pip
    private func pipXPosition(for position: UnitPoint) -> CGFloat {
        switch position {
        case .topLeading, .leading, .bottomLeading:
            return faceSize * 0.25
        case .top, .center, .bottom:
            return faceSize * 0.5
        case .topTrailing, .trailing, .bottomTrailing:
            return faceSize * 0.75
        default:
            return faceSize * 0.5
        }
    }
    
    // Helper to calculate Y position for pip
    private func pipYPosition(for position: UnitPoint) -> CGFloat {
        switch position {
        case .topLeading, .top, .topTrailing:
            return faceSize * 0.25
        case .leading, .center, .trailing:
            return faceSize * 0.5
        case .bottomLeading, .bottom, .bottomTrailing:
            return faceSize * 0.75
        default:
            return faceSize * 0.5
        }
    }
}

// Preview provider for Xcode development
struct ImprovedDiceView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Show all possible dice values
            ForEach(1...6, id: \.self) { value in
                ImprovedDiceView(value: value)
            }
        }
        .padding()
    }
}
