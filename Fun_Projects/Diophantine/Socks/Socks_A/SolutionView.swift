//
// SockDrawer
// SolutionView.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//


import SwiftUI

struct SolutionView: View {
    @StateObject var solver = SockProblemSolver()

    var body: some View {
        VStack {
            Text("Solution")
                .font(.title)
                .padding()

            Button("Find Solution") {
                solver.solveProblem()
            }
            .padding()

            if solver.solutionFound {
                Text("Total Socks: \(solver.totalSocks)")
                Text("Red Socks: \(solver.redSocks)")
                Text("Black Socks: \(solver.blackSocks)")
            } else {
                Text("No solution found within the tested range.")
            }
            Spacer()
        }
    }
}
