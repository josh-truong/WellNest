//
//  WorkoutDetails.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var vm: ExerciseDetailViewModel = .init()
    @Binding var exercise: WgerExerciseDetail
   
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(exercise.name)")
                .font(.title)
                .padding(.horizontal, 30)
            
            HStack {
                Spacer()
                Button {
                    ActivityEntity().add(Custom(name: exercise.name), active: true, context: managedObjContext)
                    dismiss()
                } label: {
                    Text("Add Exercise")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding()
                Spacer()
            }
        }
    }
}
