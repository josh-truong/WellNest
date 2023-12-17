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
            VStack {
                if let categories = viewModel.exerciseDictionary, !categories.isEmpty {
                    List {
                        ForEach(categories.keys.sorted(), id: \.self) { key in
                            ExerciseCategoryView(label: key, exercises: categories[key]!.exercises)
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
                else {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.gray)
                        Text("No Results")
                            .opacity(0.8)
                            .bold()
                        Text("Search for exercises")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        Text("via the search bar above")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
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
