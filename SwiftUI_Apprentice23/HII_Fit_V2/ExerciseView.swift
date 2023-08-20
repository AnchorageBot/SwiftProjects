//
//  ExerciseView.swift
//  HII_Fit
//
//  Created on 8/19/23
//

import SwiftUI

struct ExerciseView: View {

    /*
     htt ps://github.com/kodecocodes/suia-materials/tree/editions/2.0/02-planning-a-paged-app/projects/starter/HIITFit/HIITFit/Videos
     */
    let videoNames = ["squat", "step-up", "burpee", "sun-salute"]
    let exerciseNames = ["Squat", "Step-up", "Burpee", "Sun Salute"]
    let index: Int

    var body: some View {
        Text(exerciseNames[index])
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}
