//
// Cubic_v5
// EnhancedCubeView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// An enhanced 3D cube dice view with better perspective and all 6 faces
struct EnhancedCubeView: View {
    // The current dice value (1-6)
    let value: Int
    
    // Size of the cube
    private let cubeSize: CGFloat = 120
    
    // Perspective parameter for 3D effect (smaller value = stronger effect)
    private let perspective: CGFloat = 0.2
    
    // Color definitions with more realistic gradient
    private let mainColorLight = Color(#colorLiteral(red: 0.9, green: 0.1, blue: 0.1, alpha: 1))
    private let mainColorDark = Color(#colorLiteral(red: 0.75, green: 0.05, blue: 0.05, alpha: 1))
    private let borderColor = Color.black
    private let highlightColor = Color.white.opacity(0.2)
    
    // Body defines the view layout
    var body: some View {
        // Create the 3D cube using ZStack to layer all 6 faces
        ZStack {
            // Face 1 - Front (shows current value)
            ZStack {
                // Face background with gradient
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorLight, mainColorDark]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                    .overlay(
                        // Light reflection highlight
                        RoundedRectangle(cornerRadius: 16)
                            .fill(highlightColor)
                            .frame(width: cubeSize * 0.8, height: cubeSize * 0.3)
                            .offset(y: -cubeSize * 0.25)
                            .blur(radius: 6)
                            .mask(
                                RoundedRectangle(cornerRadius: 16)
                                    .frame(width: cubeSize, height: cubeSize)
                            )
                    )
                
                // Pip pattern based on face value
                DicePips(value: opposite(of: 1), size: cubeSize)
            }
            .zIndex(6) // Ensure proper layering
            
            // Face 2 - Back (opposite to front)
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorDark, mainColorLight]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Back face always shows opposite of front
                DicePips(value: opposite(of: value), size: cubeSize)
            }
            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            .offset(x: 0, y: 0)
            .zIndex(1)
            
            // Face 3 - Right
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorLight.opacity(0.9), mainColorDark.opacity(0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Right face pip pattern (always 3 on standard dice)
                DicePips(value: 3, size: cubeSize)
            }
            .rotation3DEffect(.degrees(90), axis: (x: 0, y: 1, z: 0), perspective: perspective)
            .offset(x: cubeSize/2)
            .zIndex(3)
            
            // Face 4 - Left
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorLight.opacity(0.9), mainColorDark.opacity(0.9)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Left face pip pattern (always 4 on standard dice)
                DicePips(value: 4, size: cubeSize)
            }
            .rotation3DEffect(.degrees(-90), axis: (x: 0, y: 1, z: 0), perspective: perspective)
            .offset(x: -cubeSize/2)
            .zIndex(2)
            
            // Face 5 - Top
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorLight.opacity(0.85), mainColorDark.opacity(0.85)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Top face pip pattern (always 5 on standard dice)
                DicePips(value: 5, size: cubeSize)
            }
            .rotation3DEffect(.degrees(-90), axis: (x: 1, y: 0, z: 0), perspective: perspective)
            .offset(y: -cubeSize/2)
            .zIndex(4)
            
            // Face 6 - Bottom
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [mainColorLight.opacity(0.85), mainColorDark.opacity(0.85)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Bottom face pip pattern (always 6 on standard dice)
                DicePips(value: 6, size: cubeSize)
            }
            .rotation3DEffect(.degrees(90), axis: (x: 1, y: 0, z: 0), perspective: perspective)
            .offset(y: cubeSize/2)
            .zIndex(5)
        }
        // Apply shadow to the entire cube for depth
        .shadow(color: Color.black.opacity(0.6), radius: 15, x: 10, y: 10)
    }
    
    // Helper to find opposite face value
    // On standard dice, opposite faces always sum to 7
    private func opposite(of value: Int) -> Int {
        return 7 - value
    }
}

// An enhanced view for rendering dice pips (dots) with better visual effects
struct DicePips: View {
    // Current dice value
    let value: Int
    
    // Size of the face
    let size: CGFloat
    
    // Pip size relative to face size
    private var pipSize: CGFloat {
        return size * 0.15
    }
    
    // Pip color with gradient for more dimension
    private var pipGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.white, Color.white.opacity(0.8)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // Define different layouts based on dice value
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Position pips according to standard dice patterns
                switch value {
                case 1:
                    // Single center pip
                    pip().position(x: geometry.size.width/2, y: geometry.size.height/2)
                    
                case 2:
                    // Two diagonal pips
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 3:
                    // Three pips - diagonal plus center
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.5, y: geometry.size.height*0.5)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 4:
                    // Four corner pips
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.75)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 5:
                    // Five pips - four corners plus center
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.5, y: geometry.size.height*0.5)
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.75)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 6:
                    // Six pips - three rows of two
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.25)
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.5)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.5)
                    pip().position(x: geometry.size.width*0.25, y: geometry.size.height*0.75)
                    pip().position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                default:
                    // Fallback for unexpected values
                    Text("\(value)")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    // Enhanced pip with inner shadow effect for more realism
    private func pip() -> some View {
        ZStack {
            // Base pip
            Circle()
                .fill(pipGradient)
                .frame(width: pipSize, height: pipSize)
            
            // Inner shadow effect
            Circle()
                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                .frame(width: pipSize * 0.9, height: pipSize * 0.9)
            
            // Highlight spot
            Circle()
                .fill(Color.white)
                .frame(width: pipSize * 0.25, height: pipSize * 0.25)
                .offset(x: -pipSize * 0.15, y: -pipSize * 0.15)
        }
        .shadow(color: Color.black.opacity(0.5), radius: 1, x: 1, y: 1)
    }
}
