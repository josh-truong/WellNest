//
//  ActivityButton.swift
//  WellNest
//
//  Created by Joshua Truong on 11/27/23.
//

import SwiftUI

struct ActivityButton: View {
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            Image(systemName: "plus.diamond")
                .font(.system(size: 50))
                .foregroundStyle(Color.gray)
                .opacity(0.8)
                .padding(5)
        }
    }
}

#Preview {
    ActivityButton()
}
