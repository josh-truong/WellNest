//
//  Meals.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct MealView: View {
    var body: some View {
        NavigationView {
            Text("Welcome to Meal Plans")
                .navigationTitle("Nutrition")
        }
        
    }
}

struct Meals_Previews: PreviewProvider {
    static var previews: some View {
        MealView()
    }
}
