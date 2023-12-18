//
//  DefaultIngredientView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/29/23.
//

import SwiftUI

struct DefaultIngredientView: View {
    @StateObject private var vm: DefaultIngredientSuggestionViewModel = .init()
    @Binding var selection: WgerIngredientResult
    
    var body: some View {
        List {
            ForEach(vm.suggestions, id: \.self)  { result in
                Button(result.name.htmlAttributedString, action: { selection = result })
            }
            HStack{
                Spacer()
                ProgressView("Loading ...")
                    .progressViewStyle(CircularProgressViewStyle())
                Spacer()
            }
        }
        .listStyle(.plain)
        .task{ await vm.getDefaultIngredients() }
    }
}
