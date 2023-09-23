//
//  WgerExerciseDataModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

struct WgerExerciseDataModel: Codable {
    let suggestions: [WgerExerciseSuggestionModel]
}

struct WgerExerciseSuggestionModel: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    let value: String
    let data: WgerExerciseDetailModel
}

struct WgerExerciseDetailModel: Codable, Identifiable {
    let id: Int
    let baseId: Int
    let name: String
    let category: String
    let image: String?
    let imageThumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case baseId = "base_id"
        case name
        case category
        case image
        case imageThumbnail = "image_thumbnail"
    }
}
