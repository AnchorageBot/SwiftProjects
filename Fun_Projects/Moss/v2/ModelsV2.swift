//
// AlaskanMossForestV2
// ModelsV2.swift
//
// Created on 10/27/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Anthropic's AI, Claude
//


import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    let position: Int
    var type: TileType
    var hasPlayer: Bool = false
    var mossGrowth: Int = 0 // 0-100%
}

enum TileType {
    case lowland
    case highland
    case birch
    case alder
    case spruce
    
    var color: Color {
        switch self {
        case .lowland: return .green.opacity(0.3)
        case .highland: return .green.opacity(0.7)
        case .birch: return .brown.opacity(0.4)
        case .alder: return .brown.opacity(0.6)
        case .spruce: return .brown.opacity(0.8)
        }
    }
    
    var description: String {
        switch self {
        case .lowland:
            return "Lowland: Moist soil supports slow moss growth (+10%)"
        case .highland:
            return "Highland: Exposed conditions limit moss growth (+5%)"
        case .birch:
            return "Birch Forest: Good shade and moderate moisture (+15%)"
        case .alder:
            return "Alder Grove: Excellent nitrogen fixation helps moss thrive (+20%)"
        case .spruce:
            return "Spruce Forest: Perfect shade and moisture for moss (+25%)"
        }
    }
}

enum MossType: String, CaseIterable {
    case sphagnum = "Sphagnum"
    case feather = "Feather Moss"
    case cushion = "Cushion Moss"
    
    var description: String {
        switch self {
        case .sphagnum:
            return "Thrives in wet lowlands, essential for peat formation"
        case .feather:
            return "Common in forest floors, especially under spruce and birch"
        case .cushion:
            return "Adapts well to highland areas, grows in dense mounds"
        }
    }
    
    var preferredHabitat: [TileType] {
        switch self {
        case .sphagnum:
            return [.lowland]
        case .feather:
            return [.spruce, .birch]
        case .cushion:
            return [.highland, .alder]
        }
    }
    
    var bonusGrowth: Int {
        return 10 // Bonus growth when in preferred habitat
    }
}
