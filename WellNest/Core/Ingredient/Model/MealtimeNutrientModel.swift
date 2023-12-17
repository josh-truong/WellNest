//
//  MealtimeNutrientModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation
import SwiftUI

struct MealtimeNutrientModel {
    var goal : Int = 0
    var calories: Int = 0
    var protein: CGFloat = 0.0
    var carbs: CGFloat = 0.0
    var fat: CGFloat = 0.0
    
    mutating func accumulate(_ record: FetchedResults<FoodEntity>.Element) {
        self.calories += Int(record.energy)
        self.protein += CGFloat(record.protein)
        self.carbs += CGFloat(record.carbohydrates)
        self.fat += CGFloat(record.fat)
    }
}
