// NutrientGoalsSettingsManager.swift

import Foundation

enum Nutrient: String, CaseIterable {
    case breakfastCal
    case lunchCal
    case dinnerCal
    case carbs
    case fats
    case proteins
}

class NutrientGoalsSettingsManager {
    private static let defaultBreakfast: Int = 600
    private static let defaultLunch: Int = 600
    private static let defaultDinner: Int = 600
    private static let defaultCarbs: Int = 325
    private static let defaultFats: Int = 78
    private static let defaultProteins: Int = 175
    
    static func getNutrientGoal(nutrient: Nutrient) -> Int {
        let key = "\(nutrient.rawValue)"
        if UserDefaults.standard.object(forKey: key) == nil {
            setNutrientGoal(nutrient: nutrient, value: defaultValue(for: nutrient))
        }
        return UserDefaults.standard.integer(forKey: key)
    }

    static func setNutrientGoal(nutrient: Nutrient, value: Int) {
        let key = "\(nutrient.rawValue)"
        UserDefaults.standard.set(value, forKey: key)
    }

    static func resetDefaults() {
        for nutrient in Nutrient.allCases {
            let key = "\(nutrient.rawValue)"
            UserDefaults.standard.set(defaultValue(for: nutrient), forKey: key)
        }
    }

    private static func defaultValue(for nutrient: Nutrient) -> Int {
        switch nutrient {
        case .breakfastCal: return defaultBreakfast
        case .lunchCal: return defaultLunch
        case .dinnerCal: return defaultDinner
        case .carbs: return defaultCarbs
        case .fats: return defaultFats
        case .proteins: return defaultProteins
        }
    }
}
