//
//  IngredientDetailView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import SwiftUI

struct IngredientDetailView: View {
    @Binding var ingredient: WgerIngredientResult?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredient Detail").font(.largeTitle)
            if let item = ingredient {
                Text("ID: \(item.id)")
                Text("Name: \(item.name)")
                Text("Code: \(item.code ?? "N/A")")
                Text("Energy: \(item.energy)")
                Text("Protein: \(item.protein)")
                Text("Carbohydrates: \(item.carbohydrates)")
                Text("Carbohydrates Sugar: \(item.carbohydratesSugar ?? "N/A")")
                Text("Fat: \(item.fat)")
                Text("Fat Saturated: \(item.fatSaturated ?? "N/A")")
                Text("Fibres: \(item.fibres ?? "N/A")")
                Text("Sodium: \(item.sodium ?? "N/A")")
                Text("License Title: \(item.licenseTitle ?? "N/A")")
                Text("License Author: \(item.licenseAuthor ?? "N/A")")
                Text("Language: \(item.language)")
            }
        }
        .padding()
    }
}

//#Preview {
//    IngredientDetailView()
//}
