//
//  WorkoutTask.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import Foundation

struct WorkoutTask: Identifiable {
    var id = UUID()
    var title: String
    var isIncomplete = true
}
