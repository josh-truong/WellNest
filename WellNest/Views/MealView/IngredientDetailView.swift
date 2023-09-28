//
//  IngredientDetailView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/28/23.
//

import SwiftUI

struct IngredientDetailView: View {
    @Binding var ingredient: WgerIngredientResult?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Ingredient Detail").font(.largeTitle)
            
        }
        .padding()
    }
}

//#Preview {
//    IngredientDetailView()
//}
