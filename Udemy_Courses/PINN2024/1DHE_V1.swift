/*

Abstract:

This Swift script is a conversion of a Python script that simulates heat transfer along a rod using the heat equation.
The script sets up the necessary parameters, such as rod length, material properties, boundary conditions, and simulation time.
It then initializes arrays for time and distance along the rod, as well as an array to store the temperature solution. The script
applies the boundary conditions to the temperature solution array and graphs the initial temperature distribution along the rod.

Comments:

- The script starts by importing the Foundation library, which provides basic functionality for Swift.
- The materials data, boundary conditions, and simulation period are defined as constants.
- The time array is created using the stride function and mapped to an array of evenly spaced values within the given interval.
- The distance array is created using the stride function and mapped to an array of evenly spaced values within the given interval.
- The temperature solution array u is initialized with zeros using the specified shape (time steps x distance steps).
- The shape of the temperature solution array is printed.
- The boundary conditions are applied to the temperature solution array by setting the left and right values for each time step.
- The temperature solution array is printed.
- A comment is added to indicate that graphing the solution requires a separate graphing library, such as Charts or Core Plot, which are not part of the standard Swift libraries.

Made with Xcode 15.4 in June of 2024 with the assistance of Anthropic's AI Claude

*/

// Swift libraries
import Foundation

// Materials data
let rodLength = 10.0
let rodMatK = 0.89
// Boundary conditions
let rodTempLeft = 100.0
let rodTempRight = 200.0
// Simulation period
let simTime = 10.0

// Time array (~ vector)
let dt = 0.0001
let timeSteps = Int(simTime / dt)
let t = stride(from: 0, to: simTime, by: dt).map { $0 } // Returns evenly spaced values within a given interval
print("time", t)

// Distance in x direction array (~ vector)
let dx = 0.1
let distanceSteps = Int(rodLength / dx)
let x = stride(from: 0, to: rodLength, by: dx).map { $0 } // Returns evenly spaced values within a given interval
print("distance in x direction", x)

// Initial conditions of u = heat equation solution = temperature
var u = Array(repeating: Array(repeating: 0.0, count: distanceSteps), count: timeSteps) // Returns an array of zeros with the specified shape and type
let shape = (u.count, u[0].count)
print("u = heat equation solution shape in terms of steps in time and distance in x", shape)

// Displays u (heat equation solution = temperature) in terms of columns and rows
for i in 0..<timeSteps {
    u[i][0] = rodTempLeft
    u[i][distanceSteps - 1] = rodTempRight
}
print("u = heat equation solution", u)

// Graphs the heat equation solution = temperature of rod along distance of rod
// Note: To graph the solution, you'll need to use a graphing library such as Charts or Core Plot
