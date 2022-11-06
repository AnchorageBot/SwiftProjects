// This script will generate an example of a dictionary

/*
 Made with:
 iPad 
 Swift Playgrounds 4.1
 Swift 5.7
 */

/*
 Reference:
 
 Learning Swift: Building Apps for MacOS, iOS, and Beyond, Manning et al 
 
 Chapter 1
 */

// A dictionary is an un-ordered collection of key:value pairs
// Dictionaries are indexed by keys
// Dictionaries use [ ] syntax

var crew = ["Captain": "Benjamin Sisko",
                       "First Officer": "Kira Nerys",
                       "Constable": "Odo",
                       "HolodeckDoorCode": "1A"]

print(crew["Captain"])
print(crew["HolodeckDoorCode"])
print()

print(crew)
print()

crew["Doctor"] = "Julian Bashir"
crew["ShuttleBay DoorCode"] = "3B"
print()

print(crew["Doctor"])
print(crew["ShuttleBay DoorCode"])
print()

print(crew)
print()

crew.removeValue(forKey: "Constable")
print(crew)
print()

crew["Security Officer"] = "Michael Eddington"
print(crew["Security Officer"])
print()

print(crew)
