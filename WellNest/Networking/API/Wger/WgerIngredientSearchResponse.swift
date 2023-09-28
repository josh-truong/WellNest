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

struct WgerIngredientSuggestion: Codable {
    let value: String
    let data: WgerIngredientData
}

struct WgerIngredientData: Codable {
    let id: Int
    let name: String
    let image: String?
    let imageThumbnail: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case imageThumbnail = "image_thumbnail"
    }
}
