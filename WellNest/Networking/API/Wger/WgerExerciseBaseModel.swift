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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.uuid = try container.decodeIfPresent(UUID.self, forKey: .uuid) ?? UUID()
        self.created = try container.decodeIfPresent(String.self, forKey: .created) ?? "unknown"
        self.lastUpdate = try container.decodeIfPresent(String.self, forKey: .lastUpdate) ?? "unknown"
        self.category = try container.decodeIfPresent(Int.self, forKey: .category) ?? -1
        self.muscles = try container.decodeIfPresent([Int].self, forKey: .muscles) ?? []
        self.musclesSecondary = try container.decodeIfPresent([Int].self, forKey: .musclesSecondary) ?? []
        self.equipment = try container.decodeIfPresent([Int].self, forKey: .equipment) ?? []
        self.variations = try container.decodeIfPresent(Int.self, forKey: .variations) ?? -1
        self.licenseAuthor = try container.decodeIfPresent(String.self, forKey: .licenseAuthor) ?? "unknown"
    }
}
