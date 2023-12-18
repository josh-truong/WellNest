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
    @State private var selection: WgerIngredientResult = .init()
    @State var showDetails: Bool = false
     
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
                    DefaultIngredientView(selection: $selection)
                } else {
                    SearchIngredientsView(results: $vm.results, selection: $selection)
                }
            } else {
                CustomIngredientView()
            }
            Spacer()
        }
        .navigationTitle("Ingredients")
        .searchable(text: $searchTerm)
        .onChange(of: isViewSearch) { oldState, newState in
            if !isViewSearch { searchTerm.removeAll() }
        }
        .onChange(of: searchTerm) { oldState, newState in
            vm.results.removeAll()
            
            Task {
                if !newState.isEmpty && newState.count > 2 {
                    isViewSearch = true
                    await vm.searchIngredient(term: newState)
                }
            }
        }
        .onChange(of: selection) { showDetails.toggle() }
        .sheet(isPresented: $showDetails) {
            IngredientInfoView(result: $selection)
                .presentationDetents([.height(500)])
                .presentationCornerRadius(12)
        }
        .onDisappear { dismiss() }
    }
}
