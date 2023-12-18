//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseCategoryView: View {
    @ObservedObject private var exerciseVM: ExerciseViewModel = .init()
    @State private var selectedExercise: WgerExerciseDetail = .init()
    @State private var showModal = false
    
    var label: String
    var exercises: [WgerExerciseDetail]
    
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                HStack {
                    Button(action: {
                        selectedExercise = exercise
                        showModal.toggle()
                    }) {
                        Text(exercise.name)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .sheet(isPresented: $showModal) {
            ExerciseDetailView(exercise: $selectedExercise)
                .presentationDetents([.height(200)])
                .presentationCornerRadius(12)
        }
    }
}
