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
    @StateObject private var vm: IngredientInfoViewModel = .init()
    @State private var showAdd: Bool = false
    @Binding var result: WgerIngredientResult
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(vm.info.name.htmlAttributedString)
                    .font(.headline)
                    .padding()
            
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
            }
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Spacer()
                    Button("Add",  action: {
                        FoodEntity().add(item: vm.info, context: managedObjContext)
                        dismiss()
                    })
                    .tint(.blue)
                    .disabled(!showAdd)
                    .opacity(showAdd ? 1.0 : 0.5)
                }
            }
        }
        .task { await vm.getIngredientInfo(ingredient: result) { status in self.showAdd = status } }
    }
}
