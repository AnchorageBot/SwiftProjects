/*
  ExerciseView.swift
  HII_Fit

  Created on 8/19/23, updated 8/27/2023
  Made with Swift 5.8, Xcode 14.3.1

  Command N -> Swift UI
*/

import SwiftUI

struct ExerciseView: View {

    let interval: TimeInterval = 30

    let index: Int
    var exercise: Exercise {
        Exercise.exercises[index]
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {

                HeaderView(exerciseName: exercise.exerciseName)
                    .padding()

                VideoPlayerView(videoName: exercise.videoName)
                    .frame(height: geometry.size.height * 0.45)

                Text(Date().addingTimeInterval(interval),
                     style: .timer)
                  .font(.system(size: geometry.size.height * 0.07))

                Button("Start/Done") { }
                    .font(.title3)
                    .padding()

                RatingView()
                    .padding()

                Spacer()

                Button("History") { }
                    .padding(.bottom)
            }
            .padding()
        }
        .padding()
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(index: 0)
    }
}
