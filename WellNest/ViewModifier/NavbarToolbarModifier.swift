//
//  ProfileIconToolbarModifier.swift
//  WellNest
//
//  Created by Joshua Truong on 9/15/23.
//

import SwiftUI

struct NavbarToolbarModifier: ViewModifier {
    var title: String
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    ProfileIconView()
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(title)
                        .font(.system(size:40))
                }
            }
    }
}

extension View {
    func toolbarNavBar(_ title: String) -> some View {
        self.modifier(NavbarToolbarModifier(title: title))
    }
}
