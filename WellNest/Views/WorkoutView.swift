//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import Foundation

struct WorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @State private var searchText = "dumbbell"
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.exerciseDataByCategory.keys.sorted(), id: \.self) { key in
                        WorkoutCategory(viewModel: viewModel, label: key, exercises: viewModel.exerciseDataByCategory[key]!.exercises)
                    }
                }
                .toolbarNavBar("Workout")
                
                Spacer()
                HStack {
                    TextField("Search a workout", text: $searchText)
                    Button("Search", systemImage: "arrow.up") {
                        Task { @MainActor in
                            await viewModel.searchExercises(term: searchText)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(viewModel: WorkoutViewModel(apiService: APIService()))
    }
}
