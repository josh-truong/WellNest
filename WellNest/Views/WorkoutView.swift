//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import Foundation

struct WorkoutView: View {
    @ObservedObject private var viewModel = WorkoutViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.exerciseData) { exercise in
                LazyVStack(alignment: .leading) {
                    ExerciseItem(exercise: exercise.data)
                }
            }
            .task {
                await viewModel.searchExercises(term: "dumbbell")
            }
            .toolbarNavBar("Workout")
        }
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
