//
// SockDrawer
// SockDrawerTests.swift
//
// Created on 12/26/24
// Swift Version 6.0
//
// ATS Project
// Tutor: Google Gemini 2.0
//

import XCTest
@testable import SockDrawer

final class SockDrawerTests: XCTestCase { // Use XCTestCase

    func testSockProblemSolver() {
        let solver = SockProblemSolver()

        // Test case 1: Solving the problem
        solver.solveProblem()
        XCTAssertTrue(solver.solutionFound, "Solution should be found.")
        XCTAssertEqual(solver.totalSocks, 4, "Total socks should be 4.")
        XCTAssertEqual(solver.redSocks, 3, "Red socks should be 3.")
        XCTAssertEqual(solver.blackSocks, 1, "Black socks should be 1.")

        // Test case 2: Check no solution when problem is already solved
        let originalTotal = solver.totalSocks
        let originalRed = solver.redSocks
        let originalBlack = solver.blackSocks
        solver.solveProblem() // Call solve again, should not change values as it will not find another solution in the given range
        XCTAssertEqual(solver.totalSocks, originalTotal, "Total socks should remain the same.")
        XCTAssertEqual(solver.redSocks, originalRed, "Red socks should remain the same.")
        XCTAssertEqual(solver.blackSocks, originalBlack, "Black socks should remain the same.")

        // Test case 3: Check if no solution is found when the range is too small
        let solver2 = SockProblemSolver()
        for r in 1...2 {
            for t in (r + 1)...3 {
                if 2 * r * (r - 1) == t * (t - 1) {
                    solver2.totalSocks = t
                    solver2.redSocks = r
                    solver2.blackSocks = t - r
                    solver2.solutionFound = true
                    break
                }
            }
        }
        XCTAssertFalse(solver2.solutionFound, "No solution should be found in this small range.")
    }
}
