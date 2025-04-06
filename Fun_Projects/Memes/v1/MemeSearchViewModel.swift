//
// MemeHunterV1
// MemeSearchViewModel.swift
//
// Created on 4/5/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - View Models
class MemeSearchViewModel: ObservableObject {
    @Published var memes: [Meme] = []
    @Published var isLoading = false
    @Published var searchQuery = ""
    
    private let service = MemeSearchService()
    
    func searchMemes() {
        isLoading = true
        service.searchMemes { [weak self] memes in
            DispatchQueue.main.async {
                self?.memes = memes
                self?.isLoading = false
            }
        }
    }
}
