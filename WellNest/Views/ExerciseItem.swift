//
//  ExerciseItem.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseItem: View {
    var exercise: WGERExerciseDetail
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image = exercise.image, let imageUrl = URL(string: "https://wger.de\(image)") {
                ResizableAsyncImage(imageUrl: imageUrl)
                    .clipped()
            }
            
            Text("\(exercise.name)")
                .font(.caption)
        }
        .padding(.leading, 20)
    }
}

#Preview {
    ExerciseItem(exercise: WGERExerciseDetail(id: 1, base_id: 1, name: "exercise", category: "category", image: "", image_thumbnail: ""))
}
