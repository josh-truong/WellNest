//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct WorkoutView: View {
    @State private var tasks: [WorkoutTask] = []
    var body: some View {
        NavigationView {
            VStack {
                AddWorkoutTaskView(tasks: $tasks)
                    .padding()
                WorkoutTaskView(tasks: $tasks)
            }
            .navigationTitle("Workout")
                .toolbarProfileIcon()
        }
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
