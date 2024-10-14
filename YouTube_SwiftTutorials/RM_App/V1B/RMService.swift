//
// RickAndMorty
// RMService.swift
//
// Created on 10/13/24
// Swift Version 6.0
//
// ATS Project
//   Tutor: Afraz Siddiqui - iOS Academy YouTube
//

// Primary API service object to get Rick and Morty data

import Foundation

final class RMService {
    /// Shared singleton instance
    static let shared = RMService()
    
    /// Privatized constructor
    private init() {}
    
    /*
    public func fetchCharacters() async throws -> [Character] {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        let data = try await Data.init(contentsOf: url)
        let characters = try JSONDecoder().decode([Character].self, from: data)
        return characters
    }
    */
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///     - request: Request instance
    ///     - completion: Callback with data or error
    public func execute(_ request: RMRequest, completion: @escaping () -> Void)  {
        
    }
}
