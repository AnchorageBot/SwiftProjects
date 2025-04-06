//
// AlaskanMossForestV3
// ContentView.swift
//
// Created on 10/27/24
// Swift Version 6.0
//
// ATS Project
// Developed with assistance from Claude (Anthropic AI)
//
// A moss growth simulation game for learning about Alaskan ecology

import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    @State private var validMoves: [Int]? = nil
    @State private var showingMoveOptions = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 16) {
                // Added padding at the top for better visibility
                Spacer()
                    .frame(height: 40)
                
                // Header Section with more padding
                headerSection(width: geometry.size.width)
                    .padding(.horizontal)
                
                // Score Section with more spacing
                scoreSection
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                // Moss Selection Section
                mossSelectionSection(width: geometry.size.width)
                    .padding(.horizontal, 8)
                
                // Game Board moved up
                gameBoard(size: geometry.size)
                    .padding(.horizontal, 8)
                
                // Info Section moved below game board
                infoSection
                    .frame(height: geometry.size.height * 0.15)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                
                // Control Section
                controlSection
                    .padding(.bottom, 16)
                
                Spacer()
            }
            .background(Color.black)
            .foregroundColor(.white)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func headerSection(width: CGFloat) -> some View {
        HStack {
            Text("Alaskan Moss Forest")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.green)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .fixedSize(horizontal: true, vertical: false)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
        }
        .background(Color.black)
        .frame(height: 50)
    }
    
    private var scoreSection: some View {
        HStack(spacing: 20) {
            ScoreBox(title: "Score", value: "\(gameState.score)")
            ScoreBox(title: "Turn", value: "\(gameState.turn)")
        }
    }
    
    private func mossSelectionSection(width: CGFloat) -> some View {
        VStack(spacing: 8) {
            Text("Select Moss Type")
                .font(.headline)
            
            HStack(spacing: 4) {
                ForEach(MossType.allCases, id: \.self) { mossType in
                    Button(action: {
                        gameState.selectedMoss = mossType
                    }) {
                        Text(mossType.rawValue)
                            .font(.system(size: 12))
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(
                                gameState.selectedMoss == mossType ?
                                Color.green : Color.gray.opacity(0.3)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(gameState.weatherMessage)
                .font(.headline)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            
            VStack(spacing: 4) {
                Text(gameState.infoMessage)
                    .font(.system(size: 13))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 8)
        }
        .padding(8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func gameBoard(size: CGSize) -> some View {
        let gridWidth = size.width - 32
        let tileSize = gridWidth / 5.2  // Slightly smaller for better spacing
        
        return LazyVGrid(
            columns: Array(repeating: GridItem(.fixed(tileSize), spacing: 4), count: 5),
            spacing: 4
        ) {
            ForEach(gameState.tiles) { tile in
                TileView(
                    tile: tile,
                    isValidMove: validMoves?.contains(tile.position) ?? false,
                    size: tileSize
                )
                .onTapGesture {
                    if validMoves?.contains(tile.position) ?? false {
                        gameState.movePlayer(to: tile.position)
                        validMoves = nil
                        showingMoveOptions = false
                    }
                }
            }
        }
    }
    
    private var controlSection: some View {
        Button(showingMoveOptions ? "Cancel Move" : "Roll Dice") {
            if showingMoveOptions {
                validMoves = nil
                showingMoveOptions = false
            } else {
                validMoves = gameState.getValidMoves()
                showingMoveOptions = true
            }
        }
        .font(.title3.bold())
        .padding(.horizontal, 32)
        .padding(.vertical, 12)
        .background(showingMoveOptions ? Color.red : Color.green)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

struct TileView: View {
    let tile: Tile
    let isValidMove: Bool
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(tile.type.color)
                .frame(width: size, height: size)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(isValidMove ? Color.yellow : Color.white,
                               lineWidth: isValidMove ? 3 : 1)
                )
            
            VStack(spacing: 2) {
                if tile.hasPlayer {
                    Circle()
                        .fill(Color.red)
                        .frame(width: size * 0.3, height: size * 0.3)
                }
                
                Text("\(tile.mossGrowth)%")
                    .font(.system(size: size * 0.25, weight: .medium))
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(4)
            }
        }
    }
}

struct ScoreBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}
