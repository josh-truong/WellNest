//
//  WgerIngredientResponse.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import Foundation

struct WgerIngredientResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [WgerIngredientResult]
    
    init() {
        self.count = -1
        self.next = ""
        self.previous = ""
        self.results = [WgerIngredientResult]()
    }
}

struct WgerIngredientResult: Codable, Identifiable, Hashable {
    let id: Int
    let uuid: UUID
    let code: String?
    let name: String
    let created: String
    let creationDate: String
    let lastUpdate: String
    let energy: Int
    let protein: String
    let carbohydrates: String
    let carbohydratesSugar: String?
    let fat: String
    let fatSaturated: String?
    let fibres: String?
    let sodium: String?
    let license: Int?
    let licenseTitle: String?
    let licenseObjectURL: String?
    let licenseAuthor: String?
    let licenseAuthorURL: String?
    let licenseDerivativeSourceURL: String?
    let language: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case code
        case name
        case created
        case creationDate = "creation_date"
        case lastUpdate = "last_update"
        case energy
        case protein
        case carbohydrates
        case carbohydratesSugar = "carbohydrates_sugar"
        case fat
        case fatSaturated = "fat_saturated"
        case fibres
        case sodium
        case license
        case licenseTitle = "license_title"
        case licenseObjectURL = "license_object_url"
        case licenseAuthor = "license_author"
        case licenseAuthorURL = "license_author_url"
        case licenseDerivativeSourceURL = "license_derivative_source_url"
        case language
    }
}
