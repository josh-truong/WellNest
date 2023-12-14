//
//  SearchIngredientsView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/11/23.
//

import SwiftUI

struct SearchIngredientsView: View {
    @Binding var results: [WgerIngredientSuggestion]
    
    @State private var selectedIngredient: WgerIngredientResult = .init()
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(results, id: \.self) { result in
                    if let data = result.data {
                        Button(data.name, action: {
                            selectedIngredient = WgerIngredientResult(id: data.id)
                            showSheet.toggle()
                        })
                    }
                }
                HStack(alignment: .center) {
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
                Spacer()
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $showSheet) {
            IngredientInfoView(result: $selectedIngredient)
        }
    }
}

