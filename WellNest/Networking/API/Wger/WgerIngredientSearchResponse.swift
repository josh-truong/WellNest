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
    let value: String
    let data: WgerIngredientData
    
    init() {
        self.value = ""
        self.data = WgerIngredientData()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(value)
    }
    
    static func == (lhs: WgerIngredientSuggestion, rhs: WgerIngredientSuggestion) -> Bool {
        lhs.id == rhs.id && lhs.value == rhs.value
    }
}

struct WgerIngredientData: Codable {
    var id: Int
    let name: String
    let image: String?
    let imageThumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case imageThumbnail = "image_thumbnail"
    }
    
    init() {
        self.id = UUID().hashValue
        self.name = ""
        self.image = nil
        self.imageThumbnail = nil
    }
}

