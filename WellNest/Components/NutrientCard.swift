//
//  NutrientCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct NutrientCard: View {
    let name: String
    let value: String
    var body: some View {
        VStack {
            Text(name)
                .subtitle()
            Text(value)
                .title()
        }
    }
}
