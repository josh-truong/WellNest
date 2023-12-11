//
//  SearchIngredientsView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/11/23.
//

import SwiftUI

struct SearchIngredientsView: View {
    @Binding var results: [WgerIngredientSuggestion]
    
    @State private var selectedIngredient: WgerIngredientSuggestion?
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(results, id: \.id) { result in
                    Button(result.data?.name ?? "", action: {
                        selectedIngredient = result
                        showSheet.toggle()
                    })
                }
                HStack(alignment: .center) {
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
                Spacer()
            }
        }
        .sheet(isPresented: $showSheet) {
            if let selectedIngredient = selectedIngredient {
                IngredientInfoView(selectedIngredient)
            }
        }
    }
}

