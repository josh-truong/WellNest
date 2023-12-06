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
        VStack {
            List {
                ForEach(vm.suggestions, id: \.self) { result in
                    NavigationLink(destination: IngredientInfoView(result).navigationBarBackButtonHidden(true)) {
                        Text(result.name)
                    }
                }
                HStack{
                    Spacer()
                    ProgressView("Loading ...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear() {
                            
                        }
                    Spacer()
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
