//
//  View+Ext.swift
//  WellNest
//
//  Created by Joshua Truong on 12/13/23.
//

import SwiftUI
import Foundation

extension View {
    func profile() -> some View {
        self.modifier(ProfileToolbarModifier())
    }
}
