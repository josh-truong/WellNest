//
//  WorkoutDetails.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct WorkoutDetail: View {
    var exercise: WgerExerciseDetail
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    WorkoutDetail(exercise: WgerExerciseDetail(
        id: 210,
        baseId: 537,
        name: "Incline Bench Press - Dumbbell",
        category: "Chest",
        image: "/media/exercise-images/16/Incline-press-1.png",
        imageThumbnail: "/media/exercise-images/16/Incline-press-1.png.30x30_q85_crop-smart.png"
    ))
}
