//
//  WorkoutDetails.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExerciseCategoryViewModel
   
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Spacer()
                Button("Add Exercise", systemImage: "plus", action: {
                    let model = TaskModel()
                    model.title = viewModel.selectedExercise.name
                    context.insert(model)
                    dismiss()
                })
            }
            Text("\(viewModel.selectedExercise.id)")
            Text("\(viewModel.selectedExercise.baseId)")
            Text("\(viewModel.selectedExercise.name)")
            Text("\(viewModel.selectedExercise.category)")
            Text("\(viewModel.selectedExercise.image ?? "")")
            Text("\(viewModel.selectedExercise.imageThumbnail ?? "")")
            
            Spacer()

            if let base = viewModel.exerciseBase {
                Text("Exercise ID: \(base.id)")
                Text("Exercise UUID: \(base.uuid)")
                Text("Created: \(base.created)")
                Text("Last Update: \(base.lastUpdate)")
                Text("Category: \(base.category)")
                Text("Muscles: \(base.muscles.map { String($0) }.joined(separator: ", "))")
                Text("Secondary Muscles: \(base.musclesSecondary.map { String($0) }.joined(separator: ", "))")
                Text("Equipment: \(base.equipment.map { String($0) }.joined(separator: ", "))")
                Text("Variations: \(base.variations ?? 0)")
                Text("License Author: \(base.licenseAuthor ?? "")")
            } else {
                VStack(alignment: .center) {
                    ProgressView()
                    Text("Loading exercise details...")
                        .onAppear {
                            Task {
                                await viewModel.getExerciseBase()
                            }
                        }
                }
            }
        }
        .onDisappear { viewModel.reset() }
        .padding()
    }
}
