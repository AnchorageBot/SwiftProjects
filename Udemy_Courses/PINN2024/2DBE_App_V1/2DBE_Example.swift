//
//  2DBE_Example.swift
//  2DBE_Example.swift
//
//  Inspired & shaped by Dr. Mohammad Samara's Udemy class on PINN
//  Created by ATS and Claude on 6/16/24
//  Made with Xcode 15.4
//

// Abstract: This file contains the implementation of the Burgers equation simulation using the explicit finite difference method. It defines the BurgersEquationSimulation class, which holds the simulation data and methods, as well as the views for displaying the initial conditions and final velocity distributions.

import SwiftUI // Import the SwiftUI framework

// Code block: Burgers equation simulation class
@MainActor // Declare that the class should run on the main actor
class BurgersEquationSimulation: ObservableObject { // Define the BurgersEquationSimulation class, which conforms to the ObservableObject protocol
    let nx = 51 // Number of grid points in the x direction
    let ny = 51 // Number of grid points in the y direction
    let nu = 0.1 // Diffusion coefficient or kinematic viscosity
    let nt = 500 // Number of time steps
    let dt = 0.001 // Time step size
    let dx: Double // Grid spacing in the x direction
    let dy: Double // Grid spacing in the y direction
    let x: [Double] // Array of grid points in the x direction
    let y: [Double] // Array of grid points in the y direction
    
    @Published var u: [[Double]] // 2D array to store the u velocity component
    @Published var v: [[Double]] // 2D array to store the v velocity component
    
    init() { // Initializer for the BurgersEquationSimulation class
        dx = 2 / Double(nx - 1) // Calculate the grid spacing in the x direction
        dy = 2 / Double(ny - 1) // Calculate the grid spacing in the y direction
        x = Array(stride(from: 0, through: 2, by: dx)) // Generate the array of grid points in the x direction
        y = Array(stride(from: 0, through: 2, by: dy)) // Generate the array of grid points in the y direction
        
        u = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Initialize the u velocity component with 1.0
        v = Array(repeating: Array(repeating: 1.0, count: nx), count: ny) // Initialize the v velocity component with 1.0
        
        setInitialConditions() // Set the initial conditions for the simulation
    }
    
    private func setInitialConditions() { // Set the initial conditions for the simulation
        let lowIndex = Int(0.75 / dy) // Calculate the lower index for the initial condition
        let highIndex = Int(1.25 / dy) + 1 // Calculate the upper index for the initial condition
        
        for i in lowIndex..<highIndex { // Loop through the rows
            for j in lowIndex..<highIndex { // Loop through the columns
                u[i][j] = 5 // Set the initial value for the u velocity component
                v[i][j] = 5 // Set the initial value for the v velocity component
            }
        }
    }
    
    func simulate() { // Perform the simulation
        for _ in 1..<nt { // Loop through the time steps
            let un = u // Store the current u velocity component
            let vn = v // Store the current v velocity component
            
            for i in 1..<nx-1 { // Loop through the rows (excluding boundaries)
                for j in 1..<ny-1 { // Loop through the columns (excluding boundaries)
                    // Update the u velocity component using the explicit finite difference method
                    u[i][j] = un[i][j] - un[i][j] * dt / dx * (un[i][j] - un[i-1][j]) - vn[i][j] * dt / dy * (un[i][j] - un[i][j-1])
                    // Update the v velocity component using the explicit finite difference method
                    v[i][j] = vn[i][j] - un[i][j] * dt / dx * (vn[i][j] - vn[i-1][j]) - vn[i][j] * dt / dy * (vn[i][j] - vn[i][j-1])
                }
            }
            
            updateBoundaryConditions() // Update the boundary conditions
        }
    }
    
    private func updateBoundaryConditions() { // Update the boundary conditions
        for i in 0..<ny { // Loop through the rows
            u[i][0] = 1 // Set the left boundary condition for u
            u[i][nx-1] = 1 // Set the right boundary condition for u
            v[i][0] = 1 // Set the left boundary condition for v
            v[i][nx-1] = 1 // Set the right boundary condition for v
        }
        
        for j in 0..<nx { // Loop through the columns
            u[0][j] = 1 // Set the top boundary condition for u
            u[ny-1][j] = 1 // Set the bottom boundary condition for u
            v[0][j] = 1 // Set the top boundary condition for v
            v[ny-1][j] = 1 // Set the bottom boundary condition for v
        }
    }
}

// Code block: Initial conditions view
struct InitialConditionsView: View { // Define the view for displaying the initial conditions
    @ObservedObject var simulation: BurgersEquationSimulation // Observe the BurgersEquationSimulation instance
    
    var body: some View { // Define the body of the view
        VStack { // Create a vertical stack
            Text("This view displays the initial conditions of the velocity components (u and v) for the Burgers equation simulation. The contour plots show the velocity distribution at the start of the simulation.")
                .padding()
            
            ContourView(x: simulation.x, y: simulation.y, values: simulation.u, colormap: .jet, title: "Initial U Velocity") // Display the contour plot for the initial u velocity
            
            ContourView(x: simulation.x, y: simulation.y, values: simulation.v, colormap: .jet, title: "Initial V Velocity") // Display the contour plot for the initial v velocity
        }
    }
}

// Code block: Final velocity view
struct FinalUVelocityView: View { // Define the view for displaying the final velocity
    @ObservedObject var simulation: BurgersEquationSimulation // Observe the BurgersEquationSimulation instance
    let component: VelocityComponent // Specify the velocity component to display
    
    var body: some View { // Define the body of the view
        VStack { // Create a vertical stack
            Text("This view displays the final velocity distribution for the \(component.rawValue.uppercased()) component after the simulation. The contour plot shows how the velocity has evolved over time.")
                .padding()
            
            ContourView(x: simulation.x, y: simulation.y, values: component == .u ? simulation.u : simulation.v, colormap: .jet, title: "Final \(component.rawValue.uppercased()) Velocity") // Display the contour plot for the final velocity
        }
    }
}

// Code block: Velocity component enumeration
enum VelocityComponent: String { // Define an enumeration for the velocity components
    case u, v // Cases for u and v components
}

// Code block: Contour view
struct ContourView: View {
    let x: [Double] // Array of grid points in the x direction
    let y: [Double] // Array of grid points in the y direction
    let values: [[Double]] // 2D array of values for the contour plot
    let colormap: Colormap // Colormap for the contour plot
    let title: String // Title of the contour plot
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<y.count, id: \.self) { i in
                        ForEach(0..<x.count, id: \.self) { j in
                            Rectangle()
                                .fill(colormap.color(for: values[i][j]))
                                .frame(width: cellWidth(for: geometry.size.width),
                                       height: cellHeight(for: geometry.size.height))
                                .position(x: cellPosition(for: j, width: geometry.size.width),
                                          y: cellPosition(for: i, height: geometry.size.height))
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
                .overlay(
                    VStack {
                        Text(title)
                            .font(.title2)
                        Spacer()
                        HStack {
                            colormap.gradient
                                .frame(height: 20)
                            VStack {
                                Text(String(format: "%.2f", values.flatMap { $0 }.min() ?? 0))
                                Spacer()
                                Text(String(format: "%.2f", values.flatMap { $0 }.max() ?? 0))
                            }
                            .font(.caption)
                        }
                    }
                    .padding()
                )
                
                HStack {
                    ForEach(0..<5) { index in
                        let xValue = x[index * (x.count - 1) / 4]
                        Text(String(format: "%.1f", xValue))
                            .font(.caption)
                            .frame(width: geometry.size.width / 4)
                    }
                }
            }
        }
    }
    
    private func cellWidth(for width: CGFloat) -> CGFloat {
        width / CGFloat(x.count)
    }
    
    private func cellHeight(for height: CGFloat) -> CGFloat {
        height / CGFloat(y.count)
    }
    
    private func cellPosition(for index: Int, width: CGFloat) -> CGFloat {
        CGFloat(index) * cellWidth(for: width) + cellWidth(for: width) / 2
    }
    
    private func cellPosition(for index: Int, height: CGFloat) -> CGFloat {
        CGFloat(index) * cellHeight(for: height) + cellHeight(for: height) / 2
    }
}

// Code block: Colormap extension
extension Colormap {
    var gradient: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
    
    var colors: [Color] {
        switch self {
        case .jet:
            return [.blue, .cyan, .yellow, .red]
        }
    }
    
    func color(for value: Double) -> Color {
        let normalizedValue = max(0, min(1, (value - minValue) / (maxValue - minValue)))
        let index = Int(normalizedValue * Double(colors.count - 1))
        return colors[index]
    }
    
    var minValue: Double {
        switch self {
        case .jet:
            return 1.0
        }
    }
    
    var maxValue: Double {
        switch self {
        case .jet:
            return 5.0
        }
    }
}

// Code block: Colormap enumeration
enum Colormap { // Define an enumeration for the colormaps
    case jet // Jet colormap
    // Add more colormaps if needed
}
