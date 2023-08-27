//
//  Exercise.swift
//  HII_Fit
//
//  Created on 8/20/23
//  Made with Swift 5.7, Xcode 14.3.1
//
//  Command N -> Swift File

import Foundation

/*
struct = named data type with properties and methods

name of the first structure matches the name of the file
 */

struct Exercise {
    let exerciseName: String
    let videoName: String


/*
enumeration is a named type and can have methods and computed properties

useful for grouping related values so the compiler can help you avoid mistakes
 like misspelling a string
*/
    
    enum ExerciseEnum: String {
        case squat = "Squat"
        case stepUp = "Step Up"
        case burpee = "Burpee"
        case sunSalute = "Sun Salute"
    }
}

extension Exercise {
    static let exercises = [
        Exercise(
            exerciseName: ExerciseEnum.squat.rawValue,
            videoName: "squat"),
        Exercise(
            exerciseName: ExerciseEnum.stepUp.rawValue,
            videoName: "step-up"),
        Exercise(
            exerciseName: ExerciseEnum.burpee.rawValue,
            videoName: "burpee"),
        Exercise(
            exerciseName: ExerciseEnum.sunSalute.rawValue,
            videoName: "sun-salute"),
    ]
}
