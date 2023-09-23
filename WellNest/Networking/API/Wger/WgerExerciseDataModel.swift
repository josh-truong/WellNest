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
    var baseId: Int
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
    
    init() {
        self.id = -1
        self.baseId = -1
        self.name = "unknown"
        self.category = "unknown"
        self.image = ""
        self.imageThumbnail = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.baseId = try container.decodeIfPresent(Int.self, forKey: .baseId) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "unknown"
        self.category = try container.decodeIfPresent(String.self, forKey: .category) ?? "unknown"
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.imageThumbnail = try container.decodeIfPresent(String.self, forKey: .imageThumbnail)
    }
}
