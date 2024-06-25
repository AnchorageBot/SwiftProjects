/*

Practical Artificial Intelligence with Swift

Closed-World Assumptions
This term describes inaccurate assumptions that the information possessed about a thiing
encapsulates or is indicative of the whole

*/

let noResponses = ["N", "n", "no", "No"]

if yesResponses.contains(input) {
    print("Answer was yes.")
} else if noResponses.contains(input) {
    print("Answer was no.")
} else {
    print("Answer was not yes or no.")
}

