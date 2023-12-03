//
//  DefaultIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import SwiftUI

struct DefaultIngredientView: View {
    @StateObject var vm: DefaultIngredientSuggestionViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.suggestions, id: \.self) { result in
                    NavigationLink(destination: IngredientInfoView(ingredient: result)) {
                        Text(result.name)
                    }
                }
            }
            .navigationDestination(for: TaskModel.self, destination: EditTaskView.init)
            .onAppear { Task { await vm.getDefaultIngredients() } }
        }
    }
}

#Preview {
    DefaultIngredientView()
}
