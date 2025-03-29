//
// AlaskanMossForestV1
// ContentView.swift
//
// Created on 10/27/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI, Claude
//


import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    @State private var validMoves: [Int]? = nil
    @State private var showingMoveOptions = false
    
    var body: some View {
        VStack {
            headerSection
            scoreSection
            mossSelectionSection
            infoSection
            gameBoard
            controlSection
        }
        .background(Color.black)
        .foregroundColor(.white)
    }
    
    private var headerSection: some View {
        Text("Alaskan Moss Forest")
            .font(.largeTitle)
            .foregroundColor(.green)
            .padding()
    }
    
    private var scoreSection: some View {
        HStack {
            Text("Score: \(gameState.score)")
                .font(.title2)
            Spacer()
            Text("Turn: \(gameState.turn)")
                .font(.title3)
        }
        .padding(.horizontal)
    }
    
    private var mossSelectionSection: some View {
        VStack {
            Text("Select Moss Type:")
                .font(.headline)
            
            Picker("Moss Type", selection: $gameState.selectedMoss) {
                ForEach(MossType.allCases, id: \.self) { mossType in
                    Text(mossType.rawValue).tag(mossType)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    
    private var infoSection: some View {
        VStack {
            Text(gameState.weatherMessage)
                .font(.headline)
                .padding(.bottom, 5)
            
            Text(gameState.infoMessage)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
    
    private var gameBoard: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
            ForEach(gameState.tiles) { tile in
                TileView(tile: tile, isValidMove: validMoves?.contains(tile.position) ?? false)
                    .onTapGesture {
                        if validMoves?.contains(tile.position) ?? false {
                            gameState.movePlayer(to: tile.position)
                            validMoves = nil
                            showingMoveOptions = false
                        }
                    }
            }
        }
        .padding()
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
        .font(.title2)
        .padding()
        .background(showingMoveOptions ? Color.red : Color.green)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.bottom)
    }
}

struct TileView: View {
    let tile: Tile
    let isValidMove: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(tile.type.color)
                .frame(height: 60)
                .border(isValidMove ? Color.yellow : Color.white, width: isValidMove ? 3 : 1)
            
            if tile.hasPlayer {
                Circle()
                    .fill(Color.red)
                    .frame(width: 20, height: 20)
            }
            
            Text("\(tile.mossGrowth)%")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
