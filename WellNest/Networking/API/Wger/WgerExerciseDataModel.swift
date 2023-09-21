//
//  WgerExerciseDataModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

struct WgerExerciseDataModel: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    let suggestions: [WGERExerciseSuggestion]
}

struct WGERExerciseSuggestion: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    let value: String
    let data: WGERExerciseDetail
}

struct WGERExerciseDetail: Codable {
    let id: Int
    let base_id: Int
    let name: String
    let category: String
    let image: String?
    let image_thumbnail: String?
}
