//
//  NutritionDetailView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/7/23.
//

import SwiftUI

struct NutritionDetailView: View {
    let food: FetchedResults<FoodEntity>.Element
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(food.name ?? "")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Energy: \(food.energy)")
            Text("Protein: \(food.protein, specifier: "%.2f")")
            Text("Carbohydrates: \(food.carbohydrates, specifier: "%.2f")")
            Text("Carbohydrates Sugar: \(food.sugarCarbContent, specifier: "%.2f")")
            Text("Fat: \(food.fat, specifier: "%.2f")")
            Text("Fat Saturated: \(food.saturatedFatContent, specifier: "%.2f")")
            Text("Fibres: \(food.fibres, specifier: "%.2f")")
            Text("Sodium: \(food.sodium, specifier: "%.2f")")
            
            Spacer()
        }
        .navigationBarTitle("Food Details", displayMode: .inline)
        .padding()
    }
}
