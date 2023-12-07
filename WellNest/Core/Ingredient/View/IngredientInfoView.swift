//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientInfoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: IngredientInfoViewModel
    @State private var showAdd: Bool = false
    
    init(_ info: WgerIngredientResult) {
        _vm = StateObject(wrappedValue: IngredientInfoViewModel(info))
    }
    
    init(_ suggestion: WgerIngredientSuggestion) {
        _vm = StateObject(wrappedValue: IngredientInfoViewModel(suggestion))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(vm.info.name)
            Text("Energy: \(vm.info.energy)")
            Text("Protein: \(vm.info.protein)")
            Text("Carbohydrates: \(vm.info.carbohydrates)")
            Text("Carbohydrates Sugar: \(vm.info.carbohydratesSugar ?? "N/A")")
            Text("Fat: \(vm.info.fat)")
            Text("Fat Saturated: \(vm.info.fatSaturated ?? "N/A")")
            Text("Fibres: \(vm.info.fibres ?? "N/A")")
            Text("Sodium: \(vm.info.sodium ?? "N/A")")
            
            Spacer()
        }
        .toolbar {
            if showAdd {
                ToolbarItem {
                    Button {
                        FoodEntity().add(item: vm.info, context: managedObjContext)
                        dismiss()
                    } label: { Image(systemName: "plus") }
                }
            }
        }
        .task { await vm.getIngredientInfo { status in self.showAdd = status } }
    }
}
