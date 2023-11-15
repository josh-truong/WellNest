//
//  DefaultIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import SwiftUI

struct DefaultIngredientView: View {
    @EnvironmentObject var viewModel: IngredientViewModel
    @State private var selectedIngredient = WgerIngredientResult()
    @State private var displaySheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.defaultIngredients.results, id: \.self) { result in
                    NavigationLink(result.name, destination: IngredientView(ingredient: result))
                }
            }
            .navigationDestination(for: TaskModel.self, destination: EditTaskView.init)
        }
        .onAppear { Task { await viewModel.requestDefaultIngredients() } }
    }
}

#Preview {
    DefaultIngredientView()
}
