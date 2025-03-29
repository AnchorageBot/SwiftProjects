//
// AlaskanMossForestV1
// GameStateV1.swift
//
// Created on 10/27/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI, Claude
//


import SwiftUI

class GameState: ObservableObject {
    @Published var tiles: [Tile]
    @Published var playerPosition: Int = 0
    @Published var score: Int = 0
    @Published var turn: Int = 1
    @Published var weatherMessage: String = "Sunny day!"
    @Published var selectedMoss: MossType = .sphagnum
    @Published var showingMossInfo: Bool = false
    @Published var showingHabitatInfo: Bool = false
    @Published var infoMessage: String = ""
    
    let gridSize = 20
    
    init() {
        tiles = (0..<20).map { position in
            let randomType = [TileType.lowland, .highland, .birch, .alder, .spruce].randomElement()!
            return Tile(position: position, type: randomType)
        }
        tiles[0].hasPlayer = true
        updateInfoMessage()
    }
    
    func rollDice() -> Int {
        Int.random(in: 1...6)
    }
    
    func getValidMoves() -> [Int] {
        let roll = rollDice()
        let forward = (playerPosition + roll) % gridSize
        let backward = (playerPosition - roll + gridSize) % gridSize
        return [forward, backward]
    }
    
    func movePlayer(to newPosition: Int) {
        tiles[playerPosition].hasPlayer = false
        playerPosition = newPosition
        tiles[playerPosition].hasPlayer = true
        
        updateMossGrowth()
        updateWeather()
        updateInfoMessage()
        turn += 1
    }
    
    func updateMossGrowth() {
        let currentTile = tiles[playerPosition]
        var growth = 0
        
        // Base growth from tile type
        switch currentTile.type {
        case .lowland: growth = 10
        case .highland: growth = 5
        case .birch: growth = 15
        case .alder: growth = 20
        case .spruce: growth = 25
        }
        
        // Bonus growth if moss is in preferred habitat
        if selectedMoss.preferredHabitat.contains(currentTile.type) {
            growth += selectedMoss.bonusGrowth
            infoMessage += "\nBonus growth in preferred habitat! (+\(selectedMoss.bonusGrowth)%)"
        }
        
        tiles[playerPosition].mossGrowth += growth
        if tiles[playerPosition].mossGrowth > 100 {
            tiles[playerPosition].mossGrowth = 100
        }
        
        score += growth
    }
    
    func updateWeather() {
        let weather = Int.random(in: 1...4)
        switch weather {
        case 1:
            weatherMessage = "Rainy day! Moss thrives!"
            tiles[playerPosition].mossGrowth += 10
            infoMessage += "\nRain bonus: +10% growth"
        case 2:
            weatherMessage = "Dry spell! Moss growth slows."
            tiles[playerPosition].mossGrowth -= 5
            infoMessage += "\nDry penalty: -5% growth"
        case 3:
            weatherMessage = "Foggy morning! Perfect for moss."
            tiles[playerPosition].mossGrowth += 5
            infoMessage += "\nFog bonus: +5% growth"
        default:
            weatherMessage = "Sunny day!"
        }
    }
    
    func updateInfoMessage() {
        let currentTile = tiles[playerPosition]
        infoMessage = """
        Current Location: \(currentTile.type.description)
        Selected Moss: \(selectedMoss.rawValue)
        Moss Info: \(selectedMoss.description)
        """
    }
}
