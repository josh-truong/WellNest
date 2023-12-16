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
    @State private var currentDate: Date = Date()
    @State private var showDetails: Bool = false
    @State private var selectedEntity: FetchedResults<FoodEntity>.Element?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) kcal (Today)")
                List {
                    MealtimeCard(type: Breakfast(), info: .init(), action: {  })
                    MealtimeCard(type: Lunch(), info: .init(), action: {  })
                    MealtimeCard(type: Dinner(), info: .init(), action: {  })
                }
                .listStyle(.plain)
                List {
                    ForEach(entities) { entity in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(entity.name ?? "")
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .bold()
                            HStack {
                                Text("\(entity.energy)") +
                                Text(" kcal").foregroundStyle(.red)
                                Spacer()
                                Text(currentDate.timeAgo(date: entity.timestamp ?? Date()))
                                    .foregroundStyle(.gray)
                                    .italic()
                            }
                        }
                        .onTapGesture {
                            selectedEntity = entity
                            showDetails.toggle()
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Nutrition")
            .onReceive(timer) { _ in currentDate = Date() }
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
