//
//  Group Client
//  CoffeeClient.swift
//  CoffeeOrderAPI
//
//  Created by ATS on 3/9/24
//

/*
 Abstract:
 
 Reference:
 Livestream - Learn how to make an API call in SwiftUI - azamsharp - YouTube
 */

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
}

struct CoffeeClient {
    
    func loadAllOrders(url: URL) async throws -> [Order] {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            // throw error invalid response
            throw NetworkError.invalidResponse
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        return orders
    }
    
}
