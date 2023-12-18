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
            VStack(alignment: .center) {
                HStack {
                    Text(vm.info.name.htmlAttributedString)
                        .font(.headline)
                    Spacer()
                }
                Spacer()
                HStack {
                    VStack {
                        Text("\(vm.info.energy)")
                            .font(.title)
                        Text("Calories")
                            .font(.subheadline)
                    }
                    Spacer()
                    ZStack {
                        Color(uiColor: .systemGray6)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(height: 100)
                        HStack {
                            Spacer()
                            NutrientCard(name: "Carbohydrates", value: "\(vm.info.carbohydrates) g")
                            Spacer()
                            NutrientCard(name: "Protein", value: "\(vm.info.protein) g")
                            Spacer()
                            NutrientCard(name: "Fat", value: "\(vm.info.fat) g")
                            Spacer()
                        }
                        .padding()
                    }
                }
                
                ZStack {
                    Color(uiColor: .systemGray6)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(height: 100)
                    HStack {
                        Spacer()
                        NutrientCard(name: "Sodium", value: "\(vm.info.sodium ?? "0") g")
                        Spacer()
                        NutrientCard(name: "Fibres", value: "\(vm.info.fibres ?? "0") g")
                        Spacer()
                        NutrientCard(name: "Carbohydrates Sugar", value: "\(vm.info.carbohydratesSugar ?? "0") g")
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    Spacer()
                    DatePicker("", selection: $selectedDate, in: Date().oneWeekAgo, displayedComponents: [.date])
                        .labelsHidden()
                    
                    Picker("", selection: $selectedMealtime) {
                        ForEach(MealtimeType.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    Spacer()
                }
                .padding(.top)
                
                HStack {
                    Spacer()
                    Button {
                        var item = SimpleWgerIngredientResult(vm.info)
                        item.timestamp = selectedDate
                        item.mealtime = selectedMealtime
                        
                        FoodEntity().add(item: item, context: managedObjContext)
                        dismiss()
                    } label: {
                        Text("Add Item")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!showAdd)
                    .opacity(showAdd ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("Add Food")
            .navigationBarTitleDisplayMode(.inline)
            .task { await vm.getIngredientInfo(ingredient: result) { status in self.showAdd = status } }
            .padding(.horizontal)
        }
    }
}
