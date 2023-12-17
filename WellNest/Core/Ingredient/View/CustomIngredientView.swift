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
    @State private var selectedDate: Date = Date()
    @State private var selectedMealtime: MealtimeType = .breakfast
    
    var body: some View {
        ScrollView {
            VStack {
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
                InputView(text: $name, title: "Food *", placeholder: "Enter food name")
                    .textFieldStyle(.roundedBorder)
                NumericInputView(input: $energy, title: "Calories", placeholder: "Enter calories")
                DisclosureGroup("Add nutrients") {
                    NumericInputView(input: $protein, title: "Protein", placeholder: "Enter protein")
                    NumericInputView(input: $carbohydrates, title: "Carbohydrates", placeholder: "Enter carbohydrates")
                    NumericInputView(input: $carbohydratesSugar, title: "Carbohydrates (Sugar)", placeholder: "Enter sugar content")
                    NumericInputView(input: $fat, title: "Fat", placeholder: "Enter fat")
                    NumericInputView(input: $fatSaturated, title: "Saturated Fat", placeholder: "Enter saturated fat")
                    NumericInputView(input: $fibres, title: "Fibres", placeholder: "Enter fibres")
                    NumericInputView(input: $sodium, title: "Sodium", placeholder: "Enter sodium")
                }
                .padding(.top)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("add") {
                    var item: SimpleWgerIngredientResult = .init()
                    print(selectedDate)
                    item.timestamp = selectedDate
                    item.mealtime = selectedMealtime
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
                .disabled(!formIsValid)
            }
        }
        .padding()
    }
}

extension CustomIngredientView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !name.isEmpty
        && energy >= 0
    }
}
