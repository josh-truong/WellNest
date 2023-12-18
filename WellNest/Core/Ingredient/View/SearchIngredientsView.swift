//
//  SearchIngredientsView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/11/23.
//

import SwiftUI

struct SearchIngredientsView: View {
    @Binding var results: [WgerIngredientSuggestion]
    @Binding var selection: WgerIngredientResult
    
    var body: some View {
        VStack {
            List {
                ForEach(results, id: \.self) { result in
                    if let data = result.data {
                        Button(data.name, action: { selection = WgerIngredientResult(id: data.id) })
                    }
                }
                HStack(alignment: .center) {
                    Spacer()
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                Spacer()
            }
            .listStyle(.plain)
        }
    }
}

