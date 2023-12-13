//
//  SettingsRowView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/2/23.
//

import SwiftUI

struct SettingsRowView: View {
    @Environment(\.colorScheme) var colorScheme
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "gear", title: "version", tintColor: Color(.systemGray))
}
