//
//  ProfileIconToolbarModifier.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import SwiftUI

struct ProfileIconToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProfileIconView()
                }
            }
    }
}

extension View {
    func toolbarProfileIcon() -> some View {
        self.modifier(ProfileIconToolbarModifier())
    }
}
