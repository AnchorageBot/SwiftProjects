//
//  ExerciseView.swift
//  HII_Fit
//
//  Created on 8/19/23
//
//  Command N -> Swift UI

import SwiftUI

struct ExerciseView: View {

    /*
     htt ps://github.com/kodecocodes/suia-materials/tree/editions/2.0/02-planning-a-paged-app/projects/starter/HIITFit/HIITFit/Videos
     */
    let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
    let exerciseNames = ["Squat", "Step-up", "Burpee", "Sun Salute"]
    let index: Int

    var body: some View {
        VStack {
            HeaderView(exerciseName: exerciseNames[index])
            Text("Video Player")
            Text("Timer")
            Text("Start/Done Button")
            Text("Rating")
            Text("History Button")
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}
