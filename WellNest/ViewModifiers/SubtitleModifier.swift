//
//  SubtitleStyle.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct SubtitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundStyle(Color.gray)
    }
}

extension View {
    func subtitle() -> some View {
        self.modifier(SubtitleModifier())
    }
}
