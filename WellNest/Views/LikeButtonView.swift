//
//  LikeButtonView.swift
//  WellNest
//
//  Created by Joshua Truong on 10/20/23.
//

import SwiftUI

struct LikeButtonView: View {
    @State private var isLiked: Bool = UserDefaults.standard.bool(forKey: "isLiked")

    var body: some View {
        VStack {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(isLiked ? .red : .gray)
                .onTapGesture {
                    isLiked.toggle()
                    UserDefaults.standard.set(isLiked, forKey: "isLiked")
                }
        }
    }
}

#Preview {
    LikeButtonView()
}
