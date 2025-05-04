//
// Cubic_v4
// CubeView.swift
//
// Created on 5/3/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI Claude
//

import SwiftUI

// A refined 3D cube dice view
struct CubeView: View {
    // The current dice value (1-6)
    let value: Int
    
    // Size of the cube
    private let cubeSize: CGFloat = 120
    
    // Color definitions
    private let mainColor = Color.red
    private let borderColor = Color.black
    
    // Body defines the view layout
    var body: some View {
        // Create the 3D cube using ZStack to layer components
        ZStack {
            // Front face
            ZStack {
                // Face background
                RoundedRectangle(cornerRadius: 16)
                    .fill(mainColor)
                    .frame(width: cubeSize, height: cubeSize)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(borderColor, lineWidth: 3)
                    )
                
                // Pip pattern based on current value
                DicePips(value: value, size: cubeSize)
            }
            .zIndex(1) // Ensure front face is on top
            
            // Right face
            RoundedRectangle(cornerRadius: 16)
                .fill(mainColor.opacity(0.7))
                .frame(width: cubeSize / 2, height: cubeSize)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor, lineWidth: 3)
                )
                .rotation3DEffect(
                    .degrees(90),
                    axis: (x: 0, y: 1, z: 0),
                    anchor: .leading,
                    anchorZ: 0,
                    perspective: 0.3
                )
                .offset(x: cubeSize / 2)
                .zIndex(0)
            
            // Top face
            RoundedRectangle(cornerRadius: 16)
                .fill(mainColor.opacity(0.8))
                .frame(width: cubeSize, height: cubeSize / 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(borderColor, lineWidth: 3)
                )
                .rotation3DEffect(
                    .degrees(-90),
                    axis: (x: 1, y: 0, z: 0),
                    anchor: .top,
                    anchorZ: 0,
                    perspective: 0.3
                )
                .offset(y: -cubeSize / 2)
                .zIndex(0)
        }
        // Apply shadow to the entire cube for depth
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 5, y: 5)
    }
}

// A specialized view just for rendering dice pips (dots)
struct DicePips: View {
    // Current dice value
    let value: Int
    
    // Size of the face
    let size: CGFloat
    
    // Pip size relative to face size
    private var pipSize: CGFloat {
        return size * 0.15
    }
    
    // Pip color
    private let pipColor = Color.white
    
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
                        .font(.system(size: size * 0.4))
                        .fontWeight(.bold)
                        .foregroundColor(pipColor)
                }
            }
        }
    }
    
    // Helper method to create a single pip
    private func pip() -> some View {
        Circle()
            .fill(pipColor)
            .frame(width: pipSize, height: pipSize)
            .shadow(color: Color.black.opacity(0.3), radius: 1, x: 1, y: 1)
    }
}
