// Adapated from R. Miikkulainen, K. O. Stanley by prompting Anthropic's AI Claude
// Made with Xcode 15.4 on 8 June 2024

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

// Function to simulate a duel between two robots
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

// Function to evolve a population of robots
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

// Create an initial population of robots
var population: [Robot] = []
for i in 0..<10 {
    let strategy = (0..<5).map { _ in Int.random(in: 0...1) }
    population.append(Robot(id: i, strategy: strategy))
}

// Evolve the population for a specified number of generations
evolve(population: population, generations: 5)
