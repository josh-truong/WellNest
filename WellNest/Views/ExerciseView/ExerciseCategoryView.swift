//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseCategoryView: View {
    @ObservedObject var exerciseVM: ExerciseViewModel
    @ObservedObject var exerciseCategoryVM: ExerciseCategoryViewModel
    var label: String
    var exercises: [WgerExerciseDetail]
    
    @State private var showModal = false
        
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                Text(exercise.name)
                    .onTapGesture {
                        exerciseCategoryVM.selectedExercise = exercise
                        showModal = true
                    }
            }
        }
        .sheet(isPresented: $showModal) {
            ExerciseDetailView(viewModel: exerciseCategoryVM)
        }
    }
}



struct ExerciseCategory_Previews: PreviewProvider {
    @ObservedObject static var exerciseVM = ExerciseViewModel(apiService: APIService())
    @ObservedObject static var exerciseCategoryVM = ExerciseCategoryViewModel(apiService: APIService())
    private static let exercise: WgerExerciseDetail = WgerExerciseData().getWgerExerciseDetail()
    
    static var previews: some View {
        exerciseCategoryVM.selectedExercise = exercise
        return ExerciseCategoryView(exerciseVM: exerciseVM, exerciseCategoryVM: exerciseCategoryVM, label: "Chest", exercises: [exercise])
    }
}
