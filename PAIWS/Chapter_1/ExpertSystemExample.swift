/*
Practical Artificial Intelligence with Swift: From Fundamental Theory to Development of AI-Driven Apps  

Expert systems are a type of applicaton designed to supplement or replace a domain expert for highly
specific information retrieval or decision-making. They boil down to something that could be represented
by many nested if statements

*/

var response: String

    if query == "Does this patient have a cold or the flu?" {
        response = ask("Do they have a fever? (Y/N)")

        if response == "Y" {
            return "Most likely the flu."
        }

        reponse = ask("Did symptoms come on rapidly? (Y/N)")

        if response == "N" {
            return "Most likely a cold."
        }

        return "Results are inconclusive."
    }

