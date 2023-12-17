//
//  SimpleWgerIngredientResult.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation

struct SimpleWgerIngredientResult {
    var id: Int = -1
    var timestamp: Date = Date()
    var mealtime: MealtimeType = .breakfast
    var name: String = ""
    var energy: Int = 0
    var protein: String = ""
    var carbohydrates: String = ""
    var carbohydratesSugar: String? = ""
    var fat: String = ""
    var fatSaturated: String? = ""
    var fibres: String? = ""
    var sodium: String? = ""
    
    init() {}
    
    init(_ item: WgerIngredientResult) {
        self.id = item.id
        self.name = item.name
        self.energy = item.energy
        self.protein = item.protein
        self.carbohydrates = item.carbohydrates
        self.carbohydratesSugar = item.carbohydratesSugar
        self.fat = item.fat
        self.fatSaturated = item.fatSaturated
        self.fibres = item.fibres
        self.sodium = item.sodium
    }
}
