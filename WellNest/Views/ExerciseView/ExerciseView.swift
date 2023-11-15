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
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationView {
            VStack() {
                if let categories = viewModel.exerciseDictionary, !categories.isEmpty {
                    List {
                        ForEach(categories.keys.sorted(), id: \.self) { key in
                            ExerciseCategoryView(exerciseVM: viewModel, exerciseCategoryVM: ExerciseCategoryViewModel(apiService: APIService.shared),label: key, exercises: categories[key]!.exercises)
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
                else {
                    Spacer()
                    Text("Nothing To See Here")
                }
                
                Spacer()
                HStack {
                    TextField("Search an exercise", text: $searchTerm)
                    Button("Search", systemImage: "arrow.up") {
                        Task {
                            await viewModel.searchExercises(term: searchTerm)
                        }
                    }
                }
                .padding()
            }
            .toolbarNavBar("Exercise")
        }
        .onDisappear { viewModel.reset() }
    }
}

struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView(viewModel: ExerciseViewModel(apiService: APIService.shared))
    }
}

