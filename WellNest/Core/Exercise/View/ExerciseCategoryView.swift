//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseCategoryView: View {
    @ObservedObject private var exerciseVM: ExerciseViewModel = .init()
    @ObservedObject private var exerciseCategoryVM: ExerciseCategoryViewModel = .init()
    
    var label: String
    var exercises: [WgerExerciseDetail]
    
    @State private var showExerciseModal = false
    
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                HStack {
                    Button(action: {
                        exerciseCategoryVM.selectedExercise = exercise
                        showExerciseModal = true
                    }) {
                        Text(exercise.name)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .sheet(isPresented: $showExerciseModal) {
            ExerciseDetailView(viewModel: exerciseCategoryVM)
        }
    }
}
