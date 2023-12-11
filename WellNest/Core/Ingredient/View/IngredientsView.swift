//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientsView: View {
    @StateObject var vm: IngredientViewModel = .init()
    @State private var searchTerm: String = ""
     
    var body: some View {
        NavigationView {
            VStack {
                if (searchTerm.isEmpty) {
                    DefaultIngredientView()
                } else {
                    SearchIngredientsView(results: $vm.results)
                }
            }
        }
        .navigationTitle("Ingredients")
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm) { oldState, newState in
            Task {
                if !newState.isEmpty && newState.count > 2 {
                    await vm.searchIngredient(term: newState)
                } else {
                    vm.results.removeAll()
                }
            }
        }
    }
}
