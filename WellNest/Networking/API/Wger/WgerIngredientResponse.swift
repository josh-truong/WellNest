import Foundation

struct WgerIngredientResponse: Codable, Equatable {
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

struct WgerIngredientResult: Codable, Hashable {
    var id: Int
    let uuid: UUID
    let code: String?
    let name: String
    let created: String
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
    
    init(id: Int = -1, uuid: UUID = UUID(), code: String? = nil, name: String = "", created: String = "", lastUpdate: String = "", energy: Int = 0, protein: String = "", carbohydrates: String = "", carbohydratesSugar: String? = nil, fat: String = "", fatSaturated: String? = nil, fibres: String? = nil, sodium: String? = nil, license: Int? = nil, licenseTitle: String? = nil, licenseObjectURL: String? = nil, licenseAuthor: String? = nil, licenseAuthorURL: String? = nil, licenseDerivativeSourceURL: String? = nil, language: Int = 0) {
        self.id = id
        self.uuid = uuid
        self.code = code
        self.name = name
        self.created = created
        self.lastUpdate = lastUpdate
        self.energy = energy
        self.protein = protein
        self.carbohydrates = carbohydrates
        self.carbohydratesSugar = carbohydratesSugar
        self.fat = fat
        self.fatSaturated = fatSaturated
        self.fibres = fibres
        self.sodium = sodium
        self.license = license
        self.licenseTitle = licenseTitle
        self.licenseObjectURL = licenseObjectURL
        self.licenseAuthor = licenseAuthor
        self.licenseAuthorURL = licenseAuthorURL
        self.licenseDerivativeSourceURL = licenseDerivativeSourceURL
        self.language = language
    }
}
