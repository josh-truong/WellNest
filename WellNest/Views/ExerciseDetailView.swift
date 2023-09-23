//
//  WorkoutDetails.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseDetailView: View {
    var exercise: WgerExerciseDetailModel
    @ObservedObject var viewModel: ExerciseViewModel
    @State private var exerciseBase: WgerExerciseBaseModel?
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(exercise.name)")
            if let base = exerciseBase {
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
                                exerciseBase = await viewModel.getExerciseBase(exercise: exercise)
                            }
                        }
                }
            }
        }
        .padding()
    }
}


struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: WgerExerciseDetailModel(
            id: 210,
            baseId: 537,
            name: "Incline Bench Press - Dumbbell",
            category: "Chest",
            image: "/media/exercise-images/16/Incline-press-1.png",
            imageThumbnail: "/media/exercise-images/16/Incline-press-1.png.30x30_q85_crop-smart.png"
        ), viewModel: ExerciseViewModel(apiService: APIService()))
    }
}
