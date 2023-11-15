//
//  Meals.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct MealView: View {
    @EnvironmentObject var viewModel: IngredientViewModel
    @State private var searchTerm: String = "Ribeye"
    @State private var selectedIngredient = WgerIngredientResult()
    @State private var showModal = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search an ingredient", text: $searchTerm)
                    Button("Search", systemImage: "arrow.up") {
                        Task {
                            await viewModel.searchIngredient(term: searchTerm)
                        }
                    }
                }
                .padding()
            
                Spacer()
                if !viewModel.results.isEmpty {
                    List {
                        ForEach(viewModel.results, id: \.self.id) { result in
                            HStack {
                                Text(result.data?.name ?? "")
                            }
                        }
                    }
                }
                else {
                    DefaultIngredientView()
                }
            }
            .toolbarNavBar("Nutrition")
        }
    }
}

struct Meals_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
            .environmentObject(IngredientViewModel())
    }
}
