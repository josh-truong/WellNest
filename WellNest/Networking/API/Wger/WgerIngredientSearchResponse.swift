//
//  WgerIngredientSearchResponseModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import Foundation

struct WgerIngredientSearchResponse: Codable {
    let suggestions: [WgerIngredientSuggestion]
}

struct WgerIngredientSuggestion: Codable, Hashable {
    var id: Int { return UUID().hashValue }
    let value: String?
    let data: WgerIngredientPreview?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(value)
    }
    
    static func == (lhs: WgerIngredientSuggestion, rhs: WgerIngredientSuggestion) -> Bool {
        lhs.id == rhs.id && lhs.value == rhs.value
    }
}

struct WgerIngredientPreview: Codable {
    let id: Int
    let name: String
    let image: String? = nil
    let imageThumbnail: String? = nil
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case imageThumbnail = "image_thumbnail"
    }
}

