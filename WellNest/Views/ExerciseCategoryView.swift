//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseCategoryView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    var label: String
    var exercises: [WgerExerciseDetailModel]
    
    @State private var selectedExercise: WgerExerciseDetailModel?
    
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                Text(exercise.name)
                    .onTapGesture {
                        selectedExercise = exercise
                    }
            }
        }
        .sheet(item: $selectedExercise) { exercise in
            ExerciseDetailView(exercise: exercise, viewModel: viewModel)
        }
    }
}

#Preview {
    ExerciseCategoryView(viewModel: ExerciseViewModel(apiService: APIService()),
                    label: "Category Type", exercises: [WgerExerciseDetailModel (
        id: 210,
        baseId: 537,
        name: "Incline Bench Press - Dumbbell",
        category: "Chest",
        image: "/media/exercise-images/16/Incline-press-1.png",
        imageThumbnail: "/media/exercise-images/16/Incline-press-1.png.30x30_q85_crop-smart.png"
    )])
}
