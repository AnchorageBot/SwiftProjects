// An adaptation from Clinton Sheppard's Genetic Algorithms with python book 
// Script was modified by prompting Anthropic's AI Claude
// Made with Xcode 15.4 on 5 June, 2024

// Abstract:
// This script demonstrates the use of a genetic algorithm to guess a target phrase.
// It generates an initial random guess and iteratively mutates it to improve its fitness.
// The fitness is determined by comparing each character of the guess with the corresponding
// character of the target phrase. The algorithm continues until the guess matches the target.

import Foundation

// MARK: - Constants

/// The set of characters that can be used to construct the guess string.
let geneSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#. 1234567890"

/// The target phrase that the algorithm aims to guess.
let target = " Hello World 1.1 !"

// MARK: - Functions

/// Generates a random string of the specified length using characters from the gene set.
/// - Parameter length: The desired length of the generated string.
/// - Returns: A random string of the specified length.
func generateParent(length: Int) -> String {
    var genes: [Character] = []
    while genes.count < length {
        let sampleSize = min(length - genes.count, geneSet.count)
        genes.append(contentsOf: geneSet.shuffled().prefix(sampleSize))
    }
    return String(genes)
}

/// Evaluates the fitness of a guess by comparing each character with the corresponding character of the target phrase.
/// - Parameter guess: The guess string to evaluate.
/// - Returns: The fitness score of the guess.
func getFitness(_ guess: String) -> Int {
    zip(target, guess).reduce(0) { $1.0 == $1.1 ? $0 + 1 : $0 }
}

/// Creates a new guess by randomly mutating a single character of the parent guess.
/// - Parameter parent: The parent string to mutate.
/// - Returns: A new string with a random mutation.
func mutate(_ parent: String) -> String {
    var childGenes = Array(parent)
    let index = Int.random(in: 0..<parent.count)
    let (newGene, alternate) = geneSet.shuffled().prefix(2).map { String($0) }
    childGenes[index] = childGenes[index] == newGene.first! ? alternate.first! : newGene.first!
    return String(childGenes)
}

/// Displays the progress of the genetic algorithm.
/// - Parameter guess: The current guess string.
func display(_ guess: String) {
    let timeDiff = Date().timeIntervalSince(startTime)
    let fitness = getFitness(guess)
    print("\(guess)\t\(fitness)\t\(timeDiff)")
}

// MARK: - Main Program

let startTime = Date()
var bestParent = generateParent(length: target.count)
var bestFitness = getFitness(bestParent)
display(bestParent)

// Iterate until the guess matches the target phrase
while true {
    let child = mutate(bestParent)
    let childFitness = getFitness(child)
    
    if bestFitness >= childFitness {
        continue
    }
    
    display(child)
    
    if childFitness >= bestParent.count {
        break
    }
    
    bestFitness = childFitness
    bestParent = child
}

/*

Comments:

The script begins with an abstract that provides an overview of the genetic algorithm and its purpose.
The geneSet constant is defined as the set of characters that can be used to construct the guess string. It is documented using a triple-slash comment for clarity.
The target constant represents the phrase that the algorithm aims to guess. It is also documented using a triple-slash comment.
The generateParent function generates a random string of a specified length using characters from the geneSet. It is documented using a triple-slash comment and parameter/return descriptions.
The getFitness function evaluates the fitness of a guess by comparing each character of the guess with the corresponding character of the target phrase. It is documented using a triple-slash comment and parameter/return descriptions.
The mutate function creates a new guess by randomly mutating a single character of the parent guess. It is documented using a triple-slash comment and parameter/return descriptions.
The display function is used to display the progress of the genetic algorithm. It prints the current guess, its fitness score, and the elapsed time since the start of the algorithm. It is documented using a triple-slash comment and a parameter description.
The main program starts by recording the startTime to keep track of the elapsed time.
The bestParent is initialized with a random guess of the same length as the target phrase using the generateParent function.
The bestFitness is calculated for the initial guess using the getFitness function.
The display function is called to print the initial guess and its fitness.
The algorithm enters a while loop that continues until the guess matches the target phrase.
Inside the loop, a new child guess is generated by mutating the bestParent using the mutate function.
The childFitness is calculated for the new guess.
If the childFitness is not better than the bestFitness, the loop continues to the next iteration using the continue statement.
If the childFitness is better, the display function is called to print the progress.
If the childFitness is equal to the length of the target phrase, indicating a perfect match, the loop is terminated using the break statement.
If the loop continues, the bestFitness and bestParent are updated with the new values.

The refactored code improves readability by using meaningful names, adding documentation comments, and organizing the code into sections using MARK comments. It follows Swift coding conventions and uses modern Swift syntax and APIs.

*/