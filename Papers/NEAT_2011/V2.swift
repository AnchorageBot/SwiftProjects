/*
Abstract:
This script demonstrates the basic principles of complexification and coevolution using a simplified version of the robot duel domain. The Robot class represents a simple robot controller with an ID, fitness, and a strategy represented as an array of integers. The script includes functions for mutation, dueling, and evolving a population of robots over multiple generations. The evolve() function evaluates fitness through duels, selects the top performers, creates offspring through mutation, and replaces the bottom half of the population with the offspring. The script creates an initial population of robots and evolves them for a specified number of generations, showcasing the principles of complexification and coevolution in a simplified manner.
*/

import Foundation

// Robot class representing a simple robot controller
class Robot {
    var id: Int
    var fitness: Int
    var strategy: [Int]
    
    init(id: Int, strategy: [Int]) {
        self.id = id
        self.fitness = 0
        self.strategy = strategy
    }
    
    // Mutate the robot's strategy by adding or removing elements
    func mutate() {
        if Bool.random() {
            // Add a new random element to the strategy
            strategy.append(Int.random(in: 0...1))
        } else if !strategy.isEmpty {
            // Remove a random element from the strategy
            strategy.remove(at: Int.random(in: 0..<strategy.count))
        }
    }
}

/*
Function: duel
Description: Simulates a duel between two robots and assigns fitness based on the similarity of their strategies.
Parameters:
- robot1: The first robot participating in the duel.
- robot2: The second robot participating in the duel.
*/
func duel(robot1: Robot, robot2: Robot) {
    // Compare the strategies of the two robots
    let commonElements = Set(robot1.strategy).intersection(robot2.strategy).count
    
    // Assign fitness based on the common elements
    if commonElements > robot2.strategy.count / 2 {
        robot1.fitness += 1
    } else {
        robot2.fitness += 1
    }
}

/*
Function: evolve
Description: Evolves a population of robots over multiple generations.
Parameters:
- population: The initial population of robots.
- generations: The number of generations to evolve the population.
*/
func evolve(population: [Robot], generations: Int) {
    var currentPopulation = population
    
    for _ in 0..<generations {
        // Evaluate fitness through duels
        for i in 0..<currentPopulation.count {
            for j in (i+1)..<currentPopulation.count {
                duel(robot1: currentPopulation[i], robot2: currentPopulation[j])
            }
        }
        
        // Sort the population by fitness
        currentPopulation.sort { $0.fitness > $1.fitness }
        
        // Select the top half of the population
        let halfCount = currentPopulation.count / 2
        let topPerformers = currentPopulation.prefix(halfCount)
        
        // Create offspring by mutating the top performers
        var offspring: [Robot] = []
        for robot in topPerformers {
            var child = Robot(id: robot.id, strategy: robot.strategy)
            child.mutate()
            offspring.append(child)
        }
        
        // Replace the bottom half of the population with the offspring
        currentPopulation.replaceSubrange(halfCount..<currentPopulation.count, with: offspring)
    }
    
    // Print the best robot's strategy
    let bestRobot = currentPopulation.first!
    print("Best Robot Strategy: \(bestRobot.strategy)")
}

/*
Function: printSummary
Description: Prints a summary of the script's execution, including the initial population and the evolved population.
Parameters:
- initialPopulation: The initial population of robots.
- evolvedPopulation: The evolved population of robots after the specified number of generations.
*/
func printSummary(initialPopulation: [Robot], evolvedPopulation: [Robot]) {
    print("Initial Population:")
    for robot in initialPopulation {
        print("Robot \(robot.id): Strategy: \(robot.strategy)")
    }
    
    print("\nEvolved Population:")
    for robot in evolvedPopulation {
        print("Robot \(robot.id): Strategy: \(robot.strategy), Fitness: \(robot.fitness)")
    }
}

// Create an initial population of robots
var population: [Robot] = []
for i in 0..<10 {
    let strategy = (0..<5).map { _ in Int.random(in: 0...1) }
    population.append(Robot(id: i, strategy: strategy))
}

// Evolve the population for a specified number of generations
let generations = 5
evolve(population: population, generations: generations)

// Print the summary of the script's execution
printSummary(initialPopulation: population, evolvedPopulation: population)
