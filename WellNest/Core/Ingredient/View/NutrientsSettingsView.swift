//
//  NutrientsSettingsView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct NutrientsSettingsView: View {
    @State private var bCals: Float
    @State private var lCals: Float
    @State private var dCals: Float
    
    @State private var protein: Float
    @State private var carbs: Float
    @State private var fat: Float
    
    init() {
        bCals = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .breakfastCal))
        lCals = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .lunchCal))
        dCals = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .dinnerCal))
        
        protein = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .proteins))
        carbs = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .carbs))
        fat = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .fats))
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Mealtime Goals")
                    .title()
                    .padding()
                Section {
                    CustomSlider(name: "Breakfast Calories", color: .yellow, value: $bCals, min: 0.0, max: 1500)
                    CustomSlider(name: "Lunch Calories", color: .blue, value: $lCals, min: 0.0, max: 1500)
                    CustomSlider(name: "Dinner Calories", color: .purple, value: $dCals, min: 0.0, max: 1500)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(alignment: .leading) {
                Text("Nutrients Goals")
                    .title()
                    .padding()
                Section {
                    CustomSlider(name: "Protein", color: .green, value: $protein, min: 0.0, max: 100)
                    CustomSlider(name: "Carbs", color: .orange, value: $carbs, min: 0.0, max: 500)
                    CustomSlider(name: "Fat", color: .yellow, value: $fat, min: 0, max: 200)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .onChange(of: bCals) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .breakfastCal, value: Int(new)) }
        .onChange(of: lCals) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .lunchCal, value: Int(new)) }
        .onChange(of: dCals) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .dinnerCal, value: Int(new)) }
        .onChange(of: protein) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .proteins, value: Int(new)) }
        .onChange(of: carbs) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .carbs, value: Int(new)) }
        .onChange(of: fat) { _, new in NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .fats, value: Int(new)) }
        .padding()
    }
}
