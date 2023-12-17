//
//  NutritionViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import Foundation
import SwiftUI

class NutritionViewModel : ObservableObject {
    @Published var sortedDates: [Date] = []
    @Published var breakfastEntities: [FetchedResults<FoodEntity>.Element] = []
    @Published var lunchEntities: [FetchedResults<FoodEntity>.Element] = []
    @Published var dinnerEntities: [FetchedResults<FoodEntity>.Element] = []
    
    @Published var breakfast: MealtimeNutrientModel = .init()
    @Published var lunch: MealtimeNutrientModel = .init()
    @Published var dinner: MealtimeNutrientModel = .init()
    
    private var results: [Date: [FetchedResults<FoodEntity>.Element]] = [:]
    
    func organizeMeals(_ entities: FetchedResults<FoodEntity>) {
        for entity in entities {
            guard let timestamp = entity.timestamp else { continue }
            let dateKey = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: timestamp)) ?? Date()
            results[dateKey, default: []].append(entity)
        }
        
        sortedDates = results.keys.sorted()
    }
    
    func setDate(_ key: Date) {
        guard let records = results[key] else { return }
        
        breakfastEntities.removeAll()
        lunchEntities.removeAll()
        dinnerEntities.removeAll()
        
        breakfast = .init()
        lunch = .init()
        dinner = .init()
        
        for record in records {
            guard let mealtime = record.mealtime else { continue }
            guard let mealtime = MealtimeType(rawValue: mealtime) else { continue }
            
            switch mealtime {
            case .breakfast:
                breakfast.accumulate(record)
                breakfastEntities.append(record)
            case .lunch:
                lunch.accumulate(record)
                lunchEntities.append(record)
            case .dinner:
                dinner.accumulate(record)
                dinnerEntities.append(record)
            }
        }
    }
}
