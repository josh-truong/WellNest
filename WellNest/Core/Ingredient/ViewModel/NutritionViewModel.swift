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
    @Published var selectedDate: Date = Date()
    
    @Published var breakfast: MealtimeNutrientModel = .init()
    @Published var lunch: MealtimeNutrientModel = .init()
    @Published var dinner: MealtimeNutrientModel = .init()
    
    private var results: [Date: [FetchedResults<FoodEntity>.Element]] = [:]
    
    func organizeMeals(_ entities: FetchedResults<FoodEntity>) {
        results = groupEntitiesByDate(entities)
        sortedDates = getSortedDates()
        if sortedDates.isEmpty || (sortedDates.last != nil && !Calendar.current.isDateInToday(sortedDates.last!)) {
            sortedDates.append(Date().startOfDay)
        }
    }

    private func groupEntitiesByDate(_ entities: FetchedResults<FoodEntity>) -> [Date: [FetchedResults<FoodEntity>.Element]] {
        var groupedResults: [Date: [FetchedResults<FoodEntity>.Element]] = [:]

        for entity in entities {
            guard let timestamp = entity.timestamp else { continue }
            let dateKey = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: timestamp)) ?? Date()
            groupedResults[dateKey, default: []].append(entity)
        }

        return groupedResults
    }

    private func getSortedDates() -> [Date] {
        return results.keys.sorted()
    }

    
    func setDate(_ key: Date) {
        breakfast.clear()
        lunch.clear()
        dinner.clear()
        
        selectedDate = results.keys.contains(key) ? key : sortedDates.last ?? Date()
        guard let records = results[key] else { return }
        
        for record in records {
            guard let mealtime = record.mealtime else { continue }
            guard let mealtime = MealtimeType(rawValue: mealtime) else { continue }
            
            switch mealtime {
            case .breakfast:
                breakfast.add(record)
            case .lunch:
                lunch.add(record)
            case .dinner:
                dinner.add(record)
            }
        }
    }
}
