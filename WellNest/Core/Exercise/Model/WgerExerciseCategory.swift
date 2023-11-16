//
//  WgerExerciseCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

struct WgerExerciseCategory : Identifiable {
    var id: Int { return UUID().hashValue }
    var name: String
    var exercises: [WgerExerciseDetail]
}
