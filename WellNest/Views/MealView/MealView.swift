//
//  Meals.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct MealView: View {
    @ObservedObject var viewModel: MealViewModel
    @State private var searchTerm: String = "Ribeye"
    @State private var selectedIngredient: WgerIngredientResult? 
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
                if let ingredients = viewModel.ingredients?.results {
                    List(ingredients, id: \.self) { ingredient in
                        Text(ingredient.name ?? "")
                            .onTapGesture {
                                selectedIngredient = ingredient
                                showModal = true
                            }
                    }
                    .sheet(isPresented: $showModal) {
                        IngredientDetailView(ingredient: $selectedIngredient)
                    }
                }
                
            }
            .toolbarNavBar("Nutrition")
        }
        .onAppear {
            Task {
                await viewModel.getIngredientPlaceholder()
            }
        }
    }
}

struct Meals_Previews: PreviewProvider {
    static var previews: some View {
        MealView(viewModel: MealViewModel(apiService: APIService()))
    }
}
