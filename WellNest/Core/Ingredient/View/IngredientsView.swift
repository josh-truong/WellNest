//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientsView: View {
    @StateObject var viewModel = IngredientViewModel()
    @State private var searchTerm: String = ""
    @State private var selectedIngredient: WgerIngredientResult?
    @State private var showModal = false
     
    var body: some View {
        NavigationStack {
            List(viewModel.results, id: \.self.id) { result in
                Text(result.data.name)
            }
            .searchable(text: $searchTerm)
            .onChange(of: searchTerm) { oldState, newState in
                Task {
                    if !newState.isEmpty && newState.count > 2 {
                        await viewModel.searchIngredient(term: newState)
                    } else {
                        viewModel.results.removeAll()
                    }
                }
            }
            .navigationTitle("Ingredients")
        }
//        NavigationView {
//            VStack {
//                HStack {
//                    TextField("Search an ingredient", text: $searchTerm)
//                    Button("Search", systemImage: "arrow.up") {
//                        Task {
//                            await viewModel.searchIngredient(term: searchTerm)
//                        }
//                    }
//                }
//                .padding()
//            
//                Spacer()
//                if !viewModel.ingredientSuggestions.isEmpty {
//                    List {
//                        ForEach(viewModel.ingredientSuggestions, id: \.self.id) { result in
//                            HStack {
//                                Text(result.data.name)
//                            }
//                        }
//                    }
//                }
//                else {
//                    DefaultIngredientView()
//                }
//            }
//            .toolbarNavBar("Nutrition")
//        }
    }
}
