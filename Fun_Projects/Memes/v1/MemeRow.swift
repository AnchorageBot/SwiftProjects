//
// MemeHunterV1
// MemeRow.swift
//
// Created on 4/5/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - Views
struct MemeRow: View {
    let meme: Meme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(meme.title)
                .font(.headline)
            
            // In a real app, you would load actual images
            // This is a placeholder
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .aspectRatio(16/9, contentMode: .fit)
                .overlay(
                    Text("Meme Image")
                        .foregroundColor(.gray)
                )
            
            // Example of how to load real images using AsyncImage (iOS 15+)
            // AsyncImage(url: URL(string: meme.url)) { image in
            //     image
            //         .resizable()
            //         .aspectRatio(contentMode: .fit)
            // } placeholder: {
            //     ProgressView()
            // }
            
            Text(meme.url)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .padding(.vertical)
    }
}
