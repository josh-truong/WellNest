//
//  NumericInputView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI

struct NumericInputView: View {
    @Binding var input: Int
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)

            TextField("Enter energy", value: $input, formatter: NumberFormatter())
                .font(.system(size: 14))
                .keyboardType(.numberPad)
        }
    }
}
