//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct WorkoutCategory: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var label: String
    var exercises: [WgerExerciseDetail]
    
    @State private var showModal = false
    
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                Text(exercise.name)
                    .onTapGesture {
                        showModal = true
                    }
                    .sheet(isPresented: $showModal) {
                        VStack{
                            
                            if let exerciseBase = viewModel.exerciseBase.first {
                                Text("\(exercise.name)")
                                Text("Exercise ID: \(exerciseBase.id)")
                                Text("Exercise UUID: \(exerciseBase.uuid)")
                                Text("Created: \(exerciseBase.created)")
                                Text("Last Update: \(exerciseBase.lastUpdate)")
                                Text("Category: \(exerciseBase.category)")
                                // Text("Muscles: \(exerciseBase.muscles)")
                                //Text("Secondary Muscles: \(exerciseBase.musclesSecondary)")
                                //Text("Equipment: \(exerciseBase.equipment)")
                                Text("Variations: \(exerciseBase.variations)")
                                //Text("License Author: \(exerciseBase.licenseAuthor)")
                            } else {
                                ProgressView()
                                Text("Loading exercise details...")
                                    .onAppear {
                                        Task { @MainActor in
                                            await viewModel.getExerciseBase(exercise: exercise)
                                        }
                                    }
                            }

                        }
                        .task {
                            await viewModel.getExerciseBase(exercise: exercise)
                        }
                    }
            }
        }
    }
}

#Preview {
    WorkoutCategory(viewModel: WorkoutViewModel(apiService: APIService()),
                    label: "Category Type", exercises: [WgerExerciseDetail(
        id: 210,
        baseId: 537,
        name: "Incline Bench Press - Dumbbell",
        category: "Chest",
        image: "/media/exercise-images/16/Incline-press-1.png",
        imageThumbnail: "/media/exercise-images/16/Incline-press-1.png.30x30_q85_crop-smart.png"
    )])
}
