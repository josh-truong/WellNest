//
//  NutrientsSettingsView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct NutrientsSettingsView: View {
    @State private var bCals: Float = 0.0
    @State private var lCals: Float = 0.0
    @State private var dCals: Float = 0.0
    
    @State private var protein: Float = 0.0
    @State private var carbs: Float = 0.0
    @State private var fat: Float = 0.0
    
    init() {
        _bCals = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .breakfastCal)))
        _lCals = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .lunchCal)))
        _dCals = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .dinnerCal)))
        _protein = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .proteins)))
        _carbs = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .carbs)))
        _fat = State(initialValue: Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .fats)))
    }
    
    var body: some View {
        NavigationStack {
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
                        CustomSlider(name: "Protein (g)", color: .green, value: $protein, min: 0.0, max: 100)
                        CustomSlider(name: "Carbs (g)", color: .orange, value: $carbs, min: 0.0, max: 500)
                        CustomSlider(name: "Fat (g)", color: .yellow, value: $fat, min: 0, max: 200)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .navigationTitle("Daily Goal Settings")
        }
        .onDisappear() {
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .breakfastCal, value: Int(bCals))
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .lunchCal, value: Int(lCals))
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .dinnerCal, value: Int(dCals))
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .proteins, value: Int(protein))
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .carbs, value: Int(carbs))
            NutrientGoalsSettingsManager.setNutrientGoal(nutrient: .fats, value: Int(fat))
        }
        .padding()
    }
}
