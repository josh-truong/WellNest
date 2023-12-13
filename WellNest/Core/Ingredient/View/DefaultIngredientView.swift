//
//  DefaultIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import SwiftUI

struct DefaultIngredientView: View {
    @StateObject var vm: DefaultIngredientSuggestionViewModel = .init()
    @State private var selectedResult: WgerIngredientResult = .init()
    @State private var showDetails: Bool = false
    
    var body: some View {
        List {
            ForEach(vm.suggestions, id: \.self)  { result in
                Button(result.name.htmlAttributedString, action: {
                    selectedResult = result
                    showDetails.toggle()
                })
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
        .listStyle(.plain)
        .onAppear { Task { await vm.getDefaultIngredients() } }
        .sheet(isPresented: $showDetails) {
            IngredientInfoView(result: $selectedResult)
        }
    }
}
