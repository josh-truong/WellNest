//
//  MealtimeNutrientModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation
import SwiftUI
import CoreData

struct MealtimeNutrientModel {
    var goal : Int = 0
    var calories: Int = 0
    var protein: CGFloat = 0.0
    var carbs: CGFloat = 0.0
    var fat: CGFloat = 0.0
    var entities: [FetchedResults<FoodEntity>.Element] = []
    
    mutating func add(_ record: FetchedResults<FoodEntity>.Element) {
        self.calories += Int(record.energy)
        self.protein += CGFloat(record.protein)
        self.carbs += CGFloat(record.carbohydrates)
        self.fat += CGFloat(record.fat)
        self.entities.append(record)
    }
    
    mutating func delete(_ item: FetchedResults<FoodEntity>.Element, context: NSManagedObjectContext) {
        withAnimation {
            self.calories -= Int(item.energy)
            self.protein -= CGFloat(item.protein)
            self.carbs -= CGFloat(item.carbohydrates)
            self.fat -= CGFloat(item.fat)
            entities.removeAll { entity in return entity == item }
            FoodEntity().delete(item: item, context: context)
        }
    }
    
    mutating func clear() {
        self.goal = 0
        self.calories = 0
        self.protein = 0.0
        self.carbs = 0.0
        self.fat = 0.0
        self.entities.removeAll()
    }
}
