// Abstract:
// This Swift script mathematically models the heat distribution along a heated aluminum rod using the 1D Heat Equation.
// It discretizes the spatial and temporal domains, sets initial and boundary conditions, and solves the heat equation
// using the explicit finite difference method. The script visualizes the initial and final temperature profiles of the rod.

import Foundation

// Materials data
let rodLength = 10.0  // Length of the aluminum rod
let rodMatK = 0.89    // Thermal conductivity of the aluminum rod

// Boundary conditions
let rodTempLeft = 100.0   // Temperature at the left end of the rod
let rodTempRight = 200.0  // Temperature at the right end of the rod

// Simulation period
let simTime = 10.0  // Total simulation time

// Time discretization
let dt = 0.0001  // Time step size
let tVector = stride(from: 0, through: simTime, by: dt)  // Time vector
print("Time: \(tVector)")

// Spatial discretization
let dx = 0.1  // Spatial step size
let xVector = stride(from: 0, through: rodLength, by: dx)  // Spatial vector
print("Distance in x direction: \(xVector)")

// Initialize the solution array
var u = Array(repeating: Array(repeating: 0.0, count: Int(rodLength / dx) + 1), count: Int(simTime / dt) + 1)  // 2D array to store the temperature values
let shape = (u.count, u[0].count)
print("Solution shape (time steps, spatial steps): \(shape)")

// Set initial and boundary conditions
for t in 0..<u.count {
    u[t][0] = rodTempLeft    // Set the left boundary condition
    u[t][u[0].count - 1] = rodTempRight  // Set the right boundary condition
}
print("Initial solution: \(u)")

// Plot the initial temperature profile
// Note: You'll need to use a suitable plotting library or framework for Swift, such as Charts or Core Plot.
// Here, we'll just print the initial temperature profile.
print("Initial Temperature Profile:")
for x in 0..<u[0].count {
    print("\(xVector[x])\t\(u[0][x])")
}

// Explicit finite difference method
for t in 1..<u.count - 1 {  // Time loop
    for x in 1..<u[0].count - 1 {  // Space loop
        u[t+1][x] = ((rodMatK * (dt/dx*dx)) * (u[t][x+1] - 2*u[t][x] + u[t][x-1])) + u[t][x]  // Finite difference equation
    }
}

print("Number of time steps: \(u.count)")

// Plot the final temperature profile
// Note: You'll need to use a suitable plotting library or framework for Swift, such as Charts or Core Plot.
// Here, we'll just print the final temperature profile.
print("Final Temperature Profile:")
for x in 0..<u[0].count {
    print("\(xVector[x])\t\(u[u.count - 1][x])")
}
