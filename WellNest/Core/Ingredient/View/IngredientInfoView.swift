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
        NavigationStack {
            VStack(alignment: .leading) {
                ItemRow(key: "Energy", value: "\(vm.info.energy) kcal")
                ItemRow(key: "Protein", value: " \(vm.info.protein) g")
                ItemRow(key: "Carbohydrates", value: "\(vm.info.carbohydrates) g")
                if let carbohydratesSugar = vm.info.carbohydratesSugar{
                    ItemRow(key: "Carbohydrates Sugar", value: "\(carbohydratesSugar) g")
                }
                ItemRow(key: "Fat", value: "\(vm.info.fat) g")
                if let fatSaturated = vm.info.fatSaturated {
                    ItemRow(key: "Fat Saturated", value: "\(fatSaturated) g")
                }
                if let fibres = vm.info.fibres {
                    ItemRow(key: "Fibres", value: "\(fibres) g")
                }
                if let sodium = vm.info.sodium {
                    ItemRow(key: "Sodium", value: "\(sodium) g")
                }
                Spacer()
            }
        }
        .navigationTitle(vm.info.name.htmlAttributedString)
        .navigationBarTitleDisplayMode(.inline)
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
