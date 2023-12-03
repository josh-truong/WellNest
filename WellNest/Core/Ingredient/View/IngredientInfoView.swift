//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientInfoView: View {
    let ingredient: WgerIngredientResult
    @StateObject private var vm = IngredientInfoViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredient Detail").font(.largeTitle)
            Text("ID: \(vm.info.id)")
            Text("Name: \(vm.info.name)")
            Text("Code: \(vm.info.code ?? "N/A")")
            Text("Energy: \(vm.info.energy)")
            Text("Protein: \(vm.info.protein)")
            Text("Carbohydrates: \(vm.info.carbohydrates)")
            Text("Carbohydrates Sugar: \(vm.info.carbohydratesSugar ?? "N/A")")
            Text("Fat: \(vm.info.fat)")
            Text("Fat Saturated: \(vm.info.fatSaturated ?? "N/A")")
            Text("Fibres: \(vm.info.fibres ?? "N/A")")
            Text("Sodium: \(vm.info.sodium ?? "N/A")")
            Text("License Title: \(vm.info.licenseTitle ?? "N/A")")
            Text("License Author: \(vm.info.licenseAuthor ?? "N/A")")
            Text("Language: \(vm.info.language)")
        }
        .padding()
        .onAppear() {
            Task {
                await vm.getIngredientInfo(ingredient)
            }
        }
    }
}
