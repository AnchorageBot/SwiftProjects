// This script will convert temperature from Celsius to Farhenheit 

// This script was made by Chat GPT
  // https://openai.com/blog/chatgpt
  // March 2023

// Tested using Swift Playgrounds - it worked
  
/* In this example, we first declare the Fahrenheit temperature as a constant of type Double. 
We then use the formula to convert the temperature to Celsius and store the result in another
constant of type Double called celsius. Finally, we print the original temperature in Fahrenheit
and the converted temperature in Celsius using string interpolation. */

let fahrenheit: Double = 68
let celsius: Double = (fahrenheit - 32) * 5/9

print("\(fahrenheit) degrees Fahrenheit is equal to \(celsius) degrees Celsius.")
