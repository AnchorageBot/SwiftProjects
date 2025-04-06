//
// MemeHunterV1
// Meme.swift
//
// Created on 4/5/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - Models
struct Meme: Identifiable, Decodable {
    let id = UUID()
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case url
    }
}
