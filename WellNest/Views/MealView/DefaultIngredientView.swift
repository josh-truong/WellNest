//
//  DefaultIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import SwiftUI

struct DefaultIngredientView: View {
    @StateObject var viewModel = DefaultIngredientViewModel()
    @State private var selectedIngredient = WgerIngredientResult()
    @State private var showModal = false
    
    var body: some View {
        List {
            ForEach(viewModel.defaultIngredients.results, id: \.self) { result in
                Text(result.name)
                    .onTapGesture {
                        selectedIngredient = result
                        showModal = true
                    }
            }
        }
        .sheet(isPresented: $showModal) {
            IngredientDetailView(ingredient: $selectedIngredient)
        }
        .onAppear {
            Task {
                await viewModel.getIngredientPlaceholder()
            }
        }
    }
}

#Preview {
    DefaultIngredientView()
}
