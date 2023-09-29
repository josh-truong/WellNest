//
//  WgerExerciseBaseInfoModel.swift
//  WellNest
//
//  Created by Joshua Truong on 9/22/23.
//

import Foundation

struct WgerExerciseBaseResponse: Codable {
    let id: Int
    let uuid: UUID
    let created: String
    let lastUpdate: String
    let category: Int
    let muscles: [Int]
    let musclesSecondary: [Int]
    let equipment: [Int]
    let variations: Int?
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
    
    init() {
        self.id = -1
        self.uuid = UUID()
        self.created = "unknown"
        self.lastUpdate = "unknown"
        self.category = -1
        self.muscles = []
        self.musclesSecondary = []
        self.equipment = []
        self.variations = -1
        self.licenseAuthor = "unknown"
    }
}
