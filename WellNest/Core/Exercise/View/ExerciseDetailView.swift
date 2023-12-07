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
    @ObservedObject private var vm: ExerciseDetailViewModel = .init()
    @Binding var exercise: WgerExerciseDetail
   
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Spacer()
                Button("Add Exercise", systemImage: "plus", action: {
                    let model = TaskModel()
                    model.title = exercise.name
                    context.insert(model)
                    dismiss()
                })
            }
            
            Text("\(exercise.id)")
            Text("\(exercise.baseId)")
            Text("\(exercise.name)")
            Text("\(exercise.category)")
            Text("\(exercise.image ?? "")")
            Text("\(exercise.imageThumbnail ?? "")")
            
            Spacer()

            if let base = vm.result {
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
                                await vm.getExerciseBase(exercise)
                            }
                        }
                }
            }
        }
        .padding()
    }
}
