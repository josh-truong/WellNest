//
//  WgerMuscleResponse.swift
//  WellNest
//
//  Created by Joshua Truong on 12/18/23.
//

import Foundation

struct WgerMuscleResponse: Codable {
    let id: Int
    let name: String
    let nameEn: String
    let isFront: Bool
    let imageUrlMain: String
    let imageUrlSecondary: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case nameEn = "name_en"
        case isFront = "is_front"
        case imageUrlMain = "image_url_main"
        case imageUrlSecondary = "image_url_secondary"
    }
}
