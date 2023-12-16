//
//  TitleStyle.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18))
    }
}

extension View {
    func title() -> some View {
        self.modifier(TitleModifier())
    }
}
