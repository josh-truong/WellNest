//
//  FoodView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI
import CoreData

struct NutritionView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)]) var entities: FetchedResults<FoodEntity>
    @StateObject private var vm: NutritionViewModel = .init()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                DayCapsulePicker(dateRange: vm.sortedDates, selection: $vm.selectedDate)
                    .onChange(of: vm.selectedDate) { vm.setDate(vm.selectedDate) }
                Text("\(Int(totalCaloriesToday())) kcal (Today)")
                ScrollView {
                    MealtimeCard(type: Breakfast(), info: $vm.breakfast, destination: IngredientsView())
                    MealtimeCard(type: Lunch(), info: $vm.lunch, destination: IngredientsView())
                    MealtimeCard(type: Dinner(), info: $vm.dinner, destination: IngredientsView())
                }
            }
            .onReceive(timer) { _ in vm.organizeMeals(entities) }
            .onAppear() { 
                vm.setDate(vm.selectedDate)
                vm.organizeMeals(entities)
            }
            .onChange(of: vm.sortedDates) { vm.setDate(vm.selectedDate) }
            .onDisappear() { vm.selectedDate = Date() }
            .navigationTitle("Nutrition")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: IngredientsView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding()
        }
    }
    
    private func totalCaloriesToday() -> Int {
        var total: Int = 0
        for item in entities {
            if Calendar.current.isDateInToday(item.timestamp!) {
                total += Int(item.energy)
            }
        }
        return total
    }
}
