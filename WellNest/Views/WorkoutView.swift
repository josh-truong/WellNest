//
//  Workout.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct WorkoutView: View {
    var body: some View {
        NavigationView {
            Text("Workout Plans")
                .navigationTitle("Workout")
        }
        
    }
}

struct Workout_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
