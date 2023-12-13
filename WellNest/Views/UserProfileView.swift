//
//  UserProfileView.swift
//  WellNest
//
//  Created by Joshua Truong on 10/20/23.
//

import SwiftUI

struct UserProfileView: View {
    let name: String

    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)

            Text(name)
                .font(.title)
                .padding()
        }
    }
}
