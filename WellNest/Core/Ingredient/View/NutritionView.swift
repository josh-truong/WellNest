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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)]) var food: FetchedResults<FoodEntity>
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalCaloriesToday())) kcal (Today)")
                List {
                    ForEach(food) { food in
                        NavigationLink(destination: Text("\(food.timestamp ?? Date())")) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.name ?? "")
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .bold()
                                HStack {
                                    Text("\(food.energy)") +
                                    Text(" kcal").foregroundStyle(.red)
                                    Spacer()
                                    Text(timeSinceNow(date: food.timestamp ?? Date()))
                                        .foregroundStyle(.gray)
                                        .italic()
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteFood)
                }
                .listStyle(.plain)
            }
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
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map { food[$0] }.forEach { RecordManager().deleteFood(food: $0, context: managedObjContext) }
        }
    }
    
    private func totalCaloriesToday() -> Int {
        var total: Int = 0
        for item in food {
            if Calendar.current.isDateInToday(item.timestamp!) {
                total += Int(item.energy)
            }
        }
        return total
    }
}
