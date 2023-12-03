//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import Foundation

struct ExerciseView: View {
    @ObservedObject private var viewModel: ExerciseViewModel = .init()
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            VStack() {
                if let categories = viewModel.exerciseDictionary, !categories.isEmpty {
                    List {
                        ForEach(categories.keys.sorted(), id: \.self) { key in
                            ExerciseCategoryView(label: key, exercises: categories[key]!.exercises)
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
                else {
                    Text("Nothing To See Here")
                }
            }
            .navigationTitle("Exercise")
            .searchable(text: $searchTerm)
            .onChange(of: searchTerm) { oldState, newState in
                Task {
                    if !newState.isEmpty && newState.count > 2 {
                        await viewModel.searchExercises(term: newState)
                    } else {
                        viewModel.exerciseDictionary?.removeAll()
                    }
                }
            }
        }
    }
}

struct Exercise_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}

