//
// MemeHunterV1
// ContentView.swift
//
// Created on 4/5/25
// Swift Version 6.0
//
// ATS Project
// Assisted by Anthropic's AI, Claude
//

import SwiftUI

// MARK: - Content View
// Main view of the MemeHunterV1 app displaying search interface and meme results

struct ContentView: View {
    @StateObject private var viewModel = MemeSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search memes", text: $viewModel.searchQuery)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    viewModel.searchMemes()
                }) {
                    Text("Search")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView("Loading memes...")
                        .padding()
                } else {
                    List(viewModel.memes) { meme in
                        MemeRow(meme: meme)
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
            .navigationTitle("Top 2 Memes")
            .onAppear {
                viewModel.searchMemes()
            }
        }
    }
}

#Preview {
    ContentView()
}

