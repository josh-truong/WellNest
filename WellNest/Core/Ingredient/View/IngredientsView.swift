//
//  IngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/12/23.
//

import SwiftUI

struct IngredientsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: IngredientViewModel = .init()
    @State private var searchTerm: String = ""
    @State private var isViewSearch: Bool = true
     
    var body: some View {
        VStack {
            Picker("", selection: $isViewSearch) {
                Text("All").tag(true)
                Text("Custom").tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 50)
            .padding(.bottom)
            if (isViewSearch) {
                if searchTerm.isEmpty {
                    DefaultIngredientView()
                } else {
                    SearchIngredientsView(results: $vm.results)
                }
            } else {
                Text("Custom View")
            }
            Spacer()
        }
        .navigationTitle("Ingredients")
        .searchable(text: $searchTerm)
        .onChange(of: isViewSearch) { oldState, newState in
            if !isViewSearch { searchTerm.removeAll() }
        }
        .onChange(of: searchTerm) { oldState, newState in
            Task {
                if !newState.isEmpty && newState.count > 2 {
                    isViewSearch = true
                    await vm.searchIngredient(term: newState)
                } else {
                    vm.results.removeAll()
                }
            }
        }
        .onDisappear { dismiss() }
    }
}
