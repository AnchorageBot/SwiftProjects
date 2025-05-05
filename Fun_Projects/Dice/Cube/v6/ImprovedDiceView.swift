//
// Cubic_v6
// ImprovedDiceView.swift
//
// Created on 5/4/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// A fully realized 3D cube dice view with proper perspective
public struct ImprovedDiceView: View {
    // The current dice value (1-6)
    public let value: Int
    
    // Customizable dice color
    public var diceColor: Color = Color(#colorLiteral(red: 0.9, green: 0.1, blue: 0.1, alpha: 1))
    
    // Public initializer
    public init(value: Int, diceColor: Color = Color(#colorLiteral(red: 0.9, green: 0.1, blue: 0.1, alpha: 1))) {
        self.value = value
        self.diceColor = diceColor
    }
    
    // Size of the cube
    private let cubeSize: CGFloat = 130
    
    // Border settings
    private let cornerRadius: CGFloat = 20
    private let borderWidth: CGFloat = 3
    
    // Perspective configuration
    private let perspective: CGFloat = 0.5
    
    // Dynamic color properties based on the provided diceColor
    private var mainColorLight: Color {
        diceColor
    }
    
    private var mainColorDark: Color {
        diceColor.opacity(0.8)
    }
    
    private var borderColor: Color = Color.black
    private var highlightColor: Color = Color.white.opacity(0.3)
    private var shadowColor: Color = Color.black.opacity(0.6)
    
    // Body defines the view layout
    public var body: some View {
        // We create a container that configures the correct 3D perspective
        ZStack {
            // This is our main 3D cube with proper perspective
            // FRONT FACE (1) - Always shows the current value
            diceFace(value: value)
                .zIndex(6)
            
            // BACK FACE (6) - Shows the opposite value
            diceFace(value: opposite(of: value))
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .zIndex(1)
            
            // RIGHT FACE (3)
            diceFace(value: 3)
                .rotation3DEffect(.degrees(90), axis: (x: 0, y: 1, z: 0),
                                perspective: perspective)
                .offset(x: cubeSize/2 - borderWidth)
                .zIndex(3)
            
            // LEFT FACE (4)
            diceFace(value: 4)
                .rotation3DEffect(.degrees(-90), axis: (x: 0, y: 1, z: 0),
                                 perspective: perspective)
                .offset(x: -cubeSize/2 + borderWidth)
                .zIndex(2)
            
            // TOP FACE (5)
            diceFace(value: 5)
                .rotation3DEffect(.degrees(-90), axis: (x: 1, y: 0, z: 0),
                                 perspective: perspective)
                .offset(y: -cubeSize/2 + borderWidth)
                .zIndex(4)
            
            // BOTTOM FACE (2)
            diceFace(value: 2)
                .rotation3DEffect(.degrees(90), axis: (x: 1, y: 0, z: 0),
                                 perspective: perspective)
                .offset(y: cubeSize/2 - borderWidth)
                .zIndex(5)
        }
        // Add a shadow to the entire cube for depth
        .shadow(color: shadowColor, radius: 15, x: 10, y: 10)
    }
    
    // Helper method to create a single face of the die
    private func diceFace(value: Int) -> some View {
        ZStack {
            // Face background with gradient
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            mainColorLight,
                            mainColorDark
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: cubeSize, height: cubeSize)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .overlay(
                    // Light reflection highlight for realism
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(highlightColor)
                        .frame(width: cubeSize * 0.85, height: cubeSize * 0.3)
                        .offset(y: -cubeSize * 0.25)
                        .blur(radius: 5)
                        .mask(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .frame(width: cubeSize, height: cubeSize)
                        )
                )
            
            // Add the pips for this face value
            EnhancedDicePips(value: value, size: cubeSize)
        }
    }
    
    // Helper to get the opposite face value
    // On standard dice, opposite faces always sum to 7
    private func opposite(of value: Int) -> Int {
        return 7 - value
    }
}

// A enhanced view for rendering dice pips with improved visuals
public struct EnhancedDicePips: View {
    // Current dice value
    public let value: Int
    
    // Size of the face
    public let size: CGFloat
    
    // Public initializer
    public init(value: Int, size: CGFloat) {
        self.value = value
        self.size = size
    }
    
    // Pip size relative to face size - larger for better visibility
    private var pipSize: CGFloat {
        return size * 0.18
    }
    
    // Pip stylings
    private let pipColor = Color.white
    private let pipShadowColor = Color.black.opacity(0.3)
    
    // Dice pips layout
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Position pips according to standard dice patterns
                switch value {
                case 1:
                    // Single center pip
                    enhancedPip()
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                    
                case 2:
                    // Two diagonal pips
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 3:
                    // Three pips - diagonal plus center
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.5, y: geometry.size.height*0.5)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 4:
                    // Four corner pips
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.75)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 5:
                    // Five pips - four corners plus center
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.25)
                    enhancedPip()
                        .position(x: geometry.size.width*0.5, y: geometry.size.height*0.5)
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.75)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.75)
                    
                case 6:
                    // Six pips - three rows of two
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.2)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.2)
                    
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.5)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.5)
                    
                    enhancedPip()
                        .position(x: geometry.size.width*0.25, y: geometry.size.height*0.8)
                    enhancedPip()
                        .position(x: geometry.size.width*0.75, y: geometry.size.height*0.8)
                    
                default:
                    // Fallback for unexpected values
                    Text("\(value)")
                        .font(.system(size: size * 0.4, weight: .bold))
                        .foregroundColor(pipColor)
                }
            }
        }
    }
    
    // Enhanced pip with 3D effect
    private func enhancedPip() -> some View {
        ZStack {
            // Main pip circle
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            pipColor,
                            pipColor.opacity(0.9)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: pipSize, height: pipSize)
                .shadow(color: pipShadowColor, radius: 2, x: 1, y: 1)
            
            // Inner shadow for depth
            Circle()
                .stroke(Color.black.opacity(0.08), lineWidth: 1)
                .frame(width: pipSize * 0.9, height: pipSize * 0.9)
            
            // Highlight spot for 3D effect
            Circle()
                .fill(Color.white)
                .frame(width: pipSize * 0.35, height: pipSize * 0.35)
                .offset(x: -pipSize * 0.18, y: -pipSize * 0.18)
                .blur(radius: 1)
        }
    }
}
