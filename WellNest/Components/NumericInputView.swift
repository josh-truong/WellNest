//
//  NumericInputView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI

struct NumericInputView: View {
    @Binding var input: Int
    @State private var strInput: String = ""
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)

            TextField("Enter energy", text: $strInput)
                .font(.system(size: 14))
                .keyboardType(.numberPad)
                .onChange(of: strInput) { _, newValue in
                    strInput = newValue.filter { "0123456789".contains($0) }
                    input = Int(strInput) ?? 0
                }
                .textFieldStyle(.roundedBorder)
        }
    }
}

