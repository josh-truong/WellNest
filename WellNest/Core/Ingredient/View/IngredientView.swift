//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientView: View {
    let ingredient: WgerIngredientResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredient Detail").font(.largeTitle)
            Text("ID: \(ingredient.id)")
            Text("Name: \(ingredient.name)")
            Text("Code: \(ingredient.code ?? "N/A")")
            Text("Energy: \(ingredient.energy)")
            Text("Protein: \(ingredient.protein)")
            Text("Carbohydrates: \(ingredient.carbohydrates)")
            Text("Carbohydrates Sugar: \(ingredient.carbohydratesSugar ?? "N/A")")
            Text("Fat: \(ingredient.fat)")
            Text("Fat Saturated: \(ingredient.fatSaturated ?? "N/A")")
            Text("Fibres: \(ingredient.fibres ?? "N/A")")
            Text("Sodium: \(ingredient.sodium ?? "N/A")")
            Text("License Title: \(ingredient.licenseTitle ?? "N/A")")
            Text("License Author: \(ingredient.licenseAuthor ?? "N/A")")
            Text("Language: \(ingredient.language)")
        }
        .padding()
    }
}
