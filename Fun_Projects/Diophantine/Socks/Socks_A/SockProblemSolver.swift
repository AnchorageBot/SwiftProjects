//
// SockDrawer
// SockProblemSolver.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import Foundation

class SockProblemSolver: ObservableObject {
    @Published var totalSocks: Int = 0
    @Published var redSocks: Int = 0
    @Published var blackSocks: Int = 0
    @Published var solutionFound: Bool = false

    func solveProblem() {
        for r in 1...100 { // Iterate through possible red socks
            for t in (r + 1)...100 { // Iterate through possible total socks
                if 2 * r * (r - 1) == t * (t - 1) {
                    self.totalSocks = t
                    self.redSocks = r
                    self.blackSocks = t - r
                    self.solutionFound = true
                    return // Stop after finding the smallest solution
                }
            }
        }
        self.solutionFound = false // No solution found in the tested range
    }
}
