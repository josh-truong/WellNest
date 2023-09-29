//
//  WgerExerciseDataModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import Foundation

struct WgerExerciseSearchResponse: Codable {
    let suggestions: [WgerExerciseSuggestion]
}

struct WgerExerciseSuggestion: Codable {
    var id: Int { return UUID().hashValue }
    let value: String
    let data: WgerExerciseDetail
}

struct WgerExerciseDetail: Codable, Identifiable {
    let id: Int
    var baseId: Int
    let name: String
    let category: String
    let image: String?
    let imageThumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case baseId = "base_id"
        case name
        case category
        case image
        case imageThumbnail = "image_thumbnail"
    }
    
    init() {
        self.id = UUID().hashValue
        self.baseId = -1
        self.name = "unknown"
        self.category = "unknown"
        self.image = ""
        self.imageThumbnail = ""
    }
}
