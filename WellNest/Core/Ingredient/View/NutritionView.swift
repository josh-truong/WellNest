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
    @State private var showSettings: Bool = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var cals: Float = 0
    @State var carbs: Float = 0
    @State var proteins: Float = 0
    @State var fats: Float = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                DayCapsulePicker(dateRange: vm.sortedDates, selection: $vm.selectedDate)
                    .onChange(of: vm.selectedDate) { vm.setDate(vm.selectedDate) }
                Text("\(vm.breakfast.calories + vm.lunch.calories + vm.dinner.calories) cal (Today)")
                ScrollView {
                    ZStack {
                        Color(uiColor: .systemGray6)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        VStack {
                            HStack {
                                ProgressBar(name: "Calories", start: Float(vm.breakfast.calories + vm.lunch.calories + vm.dinner.calories), goal: cals, color: .red)
                                ProgressBar(name: "Carbs", start: Float(vm.breakfast.carbs + vm.lunch.carbs + vm.dinner.carbs), goal: carbs, color: .blue)
                            }
                            
                            HStack {
                                ProgressBar(name: "Protein", start: Float(vm.breakfast.protein + vm.lunch.protein + vm.dinner.protein), goal: proteins, color: .green)
                                ProgressBar(name: "Fat", start: Float(vm.breakfast.fat + vm.lunch.fat + vm.dinner.fat), goal: fats, color: .yellow)
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                    
                    MealtimeCard(type: Breakfast(), info: $vm.breakfast, destination: IngredientsView())
                    MealtimeCard(type: Lunch(), info: $vm.lunch, destination: IngredientsView())
                    MealtimeCard(type: Dinner(), info: $vm.dinner, destination: IngredientsView())
                }
                .scrollIndicators(.hidden)
            }
            .onReceive(timer) { _ in vm.organizeMeals(entities) }
            .onAppear() {
                vm.setDate(vm.selectedDate)
                vm.organizeMeals(entities)
                
                cals = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .breakfastCal))
                    + Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .lunchCal))
                    + Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .dinnerCal))
                carbs = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .carbs))
                proteins = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .proteins))
                fats = Float(NutrientGoalsSettingsManager.getNutrientGoal(nutrient: .fats))
            }
            .onChange(of: vm.sortedDates) { vm.setDate(vm.selectedDate) }
            .onDisappear() { vm.selectedDate = Date() }
            .navigationTitle("Nutrition")
            .sheet(isPresented: $showSettings, content: {
                NutrientsSettingsView()
                    .presentationDetents([.height(700)])
                    .presentationCornerRadius(12)
            })
            .toolbar {
                ToolbarItem {
                    Button("", systemImage: "calendar", action: {
                        withAnimation {
                            vm.setDate(Date())
                            vm.organizeMeals(entities)
                        }
                    })
                }
                ToolbarItem {
                    Button("", systemImage: "gearshape", action: {
                        withAnimation {
                            showSettings.toggle()
                        }
                    })
                }
            }
            .padding()
        }
    }
}
