//
//  Inspired & shaped by Dr. Mohammad Samara's Udemy class on PINN
//  Created by ATS and Anthropic's AI, Claude on 6/16/24
//  Made with Xcode 15.4

/*
Abstract:

This script numerically solves the 2D Burgers equation using the finite difference method to model the velocity
distribution of a fluid flow. The Burgers equation is a nonlinear partial differential equation that describes
the evolution of a velocity field over time. In this script, we solve the equation numerically using the explicit
finite difference method to model the velocity distribution in two dimensions (x and y).


*/

import Foundation

// Code Block 1: Import necessary libraries
import Accelerate // Import the Accelerate framework for numerical computing

// Code Block 2: Set up domain and parameters
let nx = 51 // Number of grid points along the x direction
let ny = 51 // Number of grid points along the y direction
let nu = 0.1 // Diffusion coefficient or kinematic viscosity
let nt = 500 // Number of time steps
let dt = 0.001 // Time step size
let dx = 2 / Double(nx - 1) // Grid spacing in the x direction (domain is from 0 to 2)
let dy = 2 / Double(ny - 1) // Grid spacing in the y direction (domain is from 0 to 2)
let x = stride(from: 0, through: 2, by: dx).map { $0 } // Array of grid points in the x direction
let y = stride(from: 0, through: 2, by: dy).map { $0 } // Array of grid points in the y direction

// Code Block 3: Initialize arrays for velocity components
var u = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Current time step for u velocity component
var v = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Current time step for v velocity component
var un = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Previous time step for u velocity component
var vn = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Previous time step for v velocity component
var uf = Array(repeating: Array(repeating: Array(repeating: 1.0, count: nx), count: ny), count: nt) // New time step for u velocity component
var vf = Array(repeating: Array(repeating: Array(repeating: 1.0, count: nx), count: ny), count: nt) // New time step for v velocity component

// Code Block 4: Set initial velocity distribution
// Set initial velocity distribution (higher velocity region in the center)
for i in Int(0.75/dy)...Int(1.25/dy) {
    for j in Int(0.75/dx)...Int(1.25/dx) {
        u[i][j] = 5
        v[i][j] = 5
        uf[0][i][j] = 5
        vf[0][i][j] = 5
    }
}

// Code Block 5: Visualize initial velocity distribution for u component
// Plotting is not as straightforward in Swift as it is in Python with Matplotlib.
// You would need to use a separate plotting library or framework to visualize the data.
// For simplicity, let's skip the visualization steps in this Swift conversion.

// Code block 6: Explicit finite difference method
for n in 1..<nt { // nt = number of time steps, start at 1 since 0 is the initial condition
    un = u // Store the previous time step for u velocity component
    vn = v // Store the previous time step for v velocity component
    
    // Walk through the entire mesh (grid) using the discretized finite difference equations
    for i in 1..<nx-1 { // Walk through x direction (excluding boundary points)
        for j in 1..<ny-1 { // Walk through y direction (excluding boundary points)
            u[i][j] = un[i][j] - un[i][j] * dt / dx * (un[i][j] - un[i-1][j]) - vn[i][j] * dt / dy * (un[i][j] - un[i][j-1])
            v[i][j] = vn[i][j] - un[i][j] * dt / dx * (vn[i][j] - vn[i-1][j]) - vn[i][j] * dt / dy * (vn[i][j] - vn[i][j-1])
            uf[n][i][j] = u[i][j] // Save the current time step solution for u velocity component
            vf[n][i][j] = v[i][j] // Save the current time step solution for v velocity component
        }
    }
    
    // Update the boundary conditions
    for i in 0..<ny {
        u[i][0] = 1 // Left boundary
        u[i][nx-1] = 1 // Right boundary
    }
    for j in 0..<nx {
        u[0][j] = 1 // Top boundary
        u[ny-1][j] = 1 // Bottom boundary
    }
    
    for i in 0..<ny {
        v[i][0] = 1 // Left boundary
        v[i][nx-1] = 1 // Right boundary
    }
    for j in 0..<nx {
        v[0][j] = 1 // Top boundary
        v[ny-1][j] = 1 // Bottom boundary
    }
}

// Code Block 7 and 8: Visualize final velocity distributions
// As mentioned earlier, visualization in Swift requires using a separate plotting library or framework.
// You would need to choose an appropriate library and adapt the visualization code accordingly.
// For the sake of simplicity, we'll skip the visualization steps in this Swift conversion.

print("Simulation completed.")
