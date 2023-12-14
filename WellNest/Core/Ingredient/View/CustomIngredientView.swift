//
//  CustomIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI

struct CustomIngredientView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var energy: Int = 0
    @State private var protein: Int = 0
    @State private var carbohydrates: Int = 0
    @State private var carbohydratesSugar: Int = 0
    @State private var fat: Int = 0
    @State private var fatSaturated: Int = 0
    @State private var fibres: Int = 0
    @State private var sodium: Int = 0
    
    var body: some View {
        VStack {
            InputView(text: $name, title: "Food", placeholder: "Enter food name")
            NumericInputView(input: $energy, title: "Energy", placeholder: "Enter energy")
            NumericInputView(input: $protein, title: "Protein", placeholder: "Enter protein")
            NumericInputView(input: $carbohydrates, title: "Carbohydrates", placeholder: "Enter carbohydrates")
            NumericInputView(input: $carbohydratesSugar, title: "Carbohydrates (Sugar)", placeholder: "Enter sugar content")
            NumericInputView(input: $fat, title: "Fat", placeholder: "Enter fat")
            NumericInputView(input: $fatSaturated, title: "Saturated Fat", placeholder: "Enter saturated fat")
            NumericInputView(input: $fibres, title: "Fibres", placeholder: "Enter fibres")
            NumericInputView(input: $sodium, title: "Sodium", placeholder: "Enter sodium")
        }
        .toolbar {
            ToolbarItem {
                Button("add") {
                    var item: WgerIngredientResult = .init()
                    item.name = name
                    item.energy = energy
                    item.protein = String(protein)
                    item.carbohydrates = String(carbohydrates)
                    item.carbohydratesSugar = String(carbohydratesSugar)
                    item.fat = String(fat)
                    item.fatSaturated = String(fatSaturated)
                    item.fibres = String(fibres)
                    item.sodium = String(sodium)
                    FoodEntity().add(item: item, context: managedObjContext)
                    dismiss()
                }
            }
        }
        .padding()
    }
}
