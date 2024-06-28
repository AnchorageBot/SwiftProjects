// MonteCarloSimulation.swift

import Foundation
import SwiftUI

struct MonteCarloSimulation {
    func estimateE(iterations: Int) -> Double {
        var sum = 0.0
        
        for _ in 0..<iterations {
            sum += randomSum()
        }
        
        return sum / Double(iterations)
    }
    
    private func randomSum() -> Double {
        var sum = 0.0
        var count = 0
        
        while sum <= 1.0 {
            sum += Double.random(in: 0...1)
            count += 1
        }
        
        return Double(count)
    }
    
    func getVisualizationNumbers(count: Int) -> [CGFloat] {
        return (0..<count).map { _ in CGFloat.random(in: 0...1) }
    }
}
