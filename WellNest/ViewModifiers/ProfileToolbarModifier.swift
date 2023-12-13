//
//  ProfileToolbarModifier.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI

struct ProfileToolbarModifier: ViewModifier {
    @State private var enableProfileModal = false
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        enableProfileModal.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .frame(width:40, height:40)
                    }
                    .sheet(isPresented: $enableProfileModal) {
                        ProfileSettingView()
                            .background(.ultraThinMaterial)
                    }
                    .padding()
                }
            }
    }
}
