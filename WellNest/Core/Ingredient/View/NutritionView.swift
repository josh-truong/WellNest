//
//  FoodView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI
import CoreData

struct NutritionView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)]) var entities: FetchedResults<FoodEntity>
    
    private let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State private var showDetails: Bool = false
    @State private var selectedEntity: FetchedResults<FoodEntity>.Element?
    @StateObject private var vm: NutritionViewModel = .init()
    @State private var selectedDate: Date = Date().startOfDay
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                DayCapsulePicker(dateRange: vm.sortedDates, selection: $selectedDate)
                    .onChange(of: selectedDate) { vm.setDate(selectedDate) }
                    .onAppear { vm.setDate(selectedDate) }
                Text("\(Int(totalCaloriesToday())) kcal (Today)")
                ScrollView {
                    MealtimeCard(type: Breakfast(), info: vm.breakfast, destination: IngredientsView())
                    MealtimeCard(type: Lunch(), info: vm.lunch, destination: IngredientsView())
                    MealtimeCard(type: Dinner(), info: vm.dinner, destination: IngredientsView())
                }
                //                List {
                //                    ForEach(entities) { entity in
                //                        VStack(alignment: .leading, spacing: 6) {
                //                            Text(entity.name ?? "")
                //                                .lineLimit(2)
                //                                .truncationMode(.tail)
                //                                .bold()
                //                            HStack {
                //                                Text("\(entity.energy)") +
                //                                Text(" kcal").foregroundStyle(.red)
                //                                Spacer()
                //                                Text(entity.timestamp ?? Date(), style: .date)
                //                                    .foregroundStyle(.gray)
                //                                    .italic()
                //                            }
                //                        }
                //                        .onTapGesture {
                //                            selectedEntity = entity
                //                            showDetails.toggle()
                //                        }
                //                    }
                //                    .onDelete(perform: deleteFood)
                //                }
                //                .listStyle(.plain)
                
            }
            .onAppear() { vm.organizeMeals(entities) }
            .navigationTitle("Nutrition")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: IngredientsView()) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showDetails) {
                if let selectedEntity = selectedEntity {
                    NutritionDetailView(food: selectedEntity)
                }
            }
            .padding()
        }
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { entities[$0] }.forEach { FoodEntity().delete(item: $0, context: managedObjContext) }
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
