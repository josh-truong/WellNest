//
//  ItemRow.swift
//  WellNest
//
//  Created by Joshua Truong on 12/11/23.
//

import SwiftUI

struct ItemRow: View {
    let key: String
    let value: String
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            HStack {
                Text(key)
                Spacer()
                Text(value)
            }
            .padding()
        }
        .frame(height: 20)
        .padding()
    }
}
