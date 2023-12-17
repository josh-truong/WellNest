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
    @State private var selectedDate: Date = Date()
    @State private var selectedMealtime: MealtimeType = .breakfast
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(vm.info.name.htmlAttributedString)
                        .font(.headline)
                        .padding()
                    HStack {
                        DatePicker("", selection: $selectedDate, in: Date().oneWeekAgo, displayedComponents: [.date])
                            .labelsHidden()
                        
                        Picker("", selection: $selectedMealtime) {
                            ForEach(MealtimeType.allCases, id: \.self) { type in
                                Text(type.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
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
            .navigationTitle("Add Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel, action: { dismiss() })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add", action: {
                        var item = SimpleWgerIngredientResult(vm.info)
                        item.timestamp = selectedDate
                        item.mealtime = selectedMealtime
                        
                        FoodEntity().add(item: item, context: managedObjContext)
                        dismiss()
                    })
                    .tint(.blue)
                    .disabled(!showAdd)
                    .opacity(showAdd ? 1.0 : 0.5)
                }
            }
            .task { await vm.getIngredientInfo(ingredient: result) { status in self.showAdd = status } }
        }
    }
}
