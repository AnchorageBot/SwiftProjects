import Foundation

/*
Abstract:
This script demonstrates a simple genetic algorithm implementation in Swift. It aims to guess a target phrase or password by
iteratively generating and mutating guesses. The fitness of each guess is evaluated based on the number of matching characters
between the guess and the target phrase. The script uses a set of possible characters (Genome) to generate random guesses and mutate
them. The goal is to evolve the guesses over generations to eventually match the target phrase.

In this Swift version of the script:

* The Genome and Gene constants are defined similarly to the Python version, representing the set of possible characters
and the target phrase, respectively.
* The guessGene function generates a random guess of the specified length using characters from the Genome set. It uses shuffled()
and prefix() to randomly sample characters and appends them to the possibleGenes array until the desired length is reached.
Finally, it converts the array to a string and returns it as the final guess.
* The getFitness function evaluates the fitness of a guess by comparing each character of the guess with the corresponding character
in the target Gene and counting the number of matches using zip() and filter().
* The mutate function takes a parent guess and creates a new guess by randomly mutating one character at a randomly selected index.
It converts the parent string to an array of characters, randomly selects an index, and replaces the character at that index with either a randomly sampled character from Genome or an alternate character if it matches the existing character at that index. Finally, it converts the array back to a string and returns it as the mutated guess.
* The example usage section demonstrates how to use the functions by generating an initial guess, calculating its fitness, mutating
the guess, and calculating the fitness of the mutated guess.


*/

// Genome: Set of possible string values representing the possible universe of characters.
// It includes lowercase letters, uppercase letters, and some special characters.
let Genome = "abcdefghijklmonopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,.?! "

// Gene: The target phrase or password that the script aims to guess.
let Gene = "Hello World!"

func guessGene(length: Int) -> String {
    /*
    This function generates a guess using values from the Genome set.
    It takes the desired length of the guess as input and returns a string of that length.
    */
    var possibleGenes: [Character] = []  // Initialize an empty array to store the possible genes.
    while possibleGenes.count < length {  // Continue generating genes until the desired length is reached.
        let geneLength = min(length - possibleGenes.count, Genome.count)  // Calculate the remaining length needed.
        let randomGenes = Genome.shuffled().prefix(geneLength)  // Randomly sample characters from Genome.
        possibleGenes.append(contentsOf: randomGenes)  // Add the randomly sampled characters to possibleGenes.
    }
    return String(possibleGenes)  // Convert the array of characters to a string and return it as the final guess.
}

func getFitness(guess: String) -> Int {
    /*
    This function evaluates the fitness of a guess by calculating the total number of characters
    in the guess that match the characters in the same position of the target Gene.
    It takes the guess string as input and returns the fitness score.
    */
    return zip(Gene, guess).filter { $0 == $1 }.count  // Compare each character of Gene and guess, and count the matches.
}

func mutate(parent: String) -> String {
    /*
    This function creates a new guess via random mutation of the old guess (parent).
    It takes the parent string as input, randomly selects an index, and mutates the character
    at that index by replacing it with a randomly sampled character from the Genome set.
    It returns the mutated string as the child guess.
    */
    var childGenes = Array(parent)  // Convert the parent string to an array of characters.
    let index = Int.random(in: 0..<parent.count)  // Randomly select an index within the range of the parent string.
    let newGene = Genome.randomElement()!  // Randomly sample a character from Genome.
    let alternate = Genome.filter { $0 != newGene }.randomElement()!  // Randomly sample an alternate character from Genome that is different from newGene.
    childGenes[index] = (newGene == childGenes[index]) ? alternate : newGene  // Replace the character at the selected index with the alternate if it matches the newGene, otherwise use the newGene.
    return String(childGenes)  // Convert the array of characters to a string and return it as the final mutated guess.
}

// Example usage of the functions
let initialGuess = guessGene(length: Gene.count)  // Generate an initial guess with the same length as the target Gene.
print("Initial guess: \(initialGuess)")  // Print the initial guess.

let fitness = getFitness(guess: initialGuess)  // Calculate the fitness of the initial guess.
print("Fitness of initial guess: \(fitness)")  // Print the fitness of the initial guess.

let mutatedGuess = mutate(parent: initialGuess)  // Create a new guess by mutating the initial guess.
print("Mutated guess: \(mutatedGuess)")  // Print the mutated guess.

let mutatedFitness = getFitness(guess: mutatedGuess)  // Calculate the fitness of the mutated guess.
print("Fitness of mutated guess: \(mutatedFitness)")  // Print the fitness of the mutated guess.
