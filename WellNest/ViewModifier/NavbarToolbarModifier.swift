//
//  ProfileIconToolbarModifier.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import SwiftUI

struct NavbarToolbarModifier: ViewModifier {
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
    func profileNavBar() -> some View {
        self.modifier(NavbarToolbarModifier())
    }
}
