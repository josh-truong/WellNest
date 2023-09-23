//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import Foundation

struct ExerciseView: View {
    @ObservedObject var viewModel: ExerciseViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.exerciseDictionary.keys.sorted(), id: \.self) { key in
                        ExerciseCategoryView(exerciseVM: viewModel, exerciseCategoryVM: ExerciseCategoryViewModel(apiService: APIService()),label: key, exercises: viewModel.exerciseDictionary[key]!.exercises)
                    }
                }
                .toolbarNavBar("Exercise")
                
                Spacer()
                HStack {
                    TextField("Search an exercise", text: $viewModel.searchExerciseTerm)
                    Button("Search", systemImage: "arrow.up") {
                        Task {
                            await viewModel.searchExercises()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(viewModel: ExerciseViewModel(apiService: APIService()))
    }
}

