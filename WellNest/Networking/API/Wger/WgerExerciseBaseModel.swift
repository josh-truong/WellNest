//
//  WgerExerciseBaseInfoModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/22/23.
//

import Foundation

struct WgerExerciseBaseModel: Codable {
    let id: Int
    let uuid: UUID
    let created: String
    let lastUpdate: String
    let category: Int
    let muscles: [Int]
    let musclesSecondary: [Int]
    let equipment: [Int]
    let variations: Int
    let licenseAuthor: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case created
        case lastUpdate = "last_update"
        case category
        case muscles
        case musclesSecondary = "muscles_secondary"
        case equipment
        case variations
        case licenseAuthor = "license_author"
    }
}
