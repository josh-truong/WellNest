//
//  UserProfileView.swift
//  WellNest
//
//  Created by Joshua Truong on 10/20/23.
//

import SwiftUI

struct UserProfileView: View {
    var imageName: String?
    var userName: String

    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill") // Use the name of your profile image
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)

            Text(userName)
                .font(.title)
                .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(imageName: "profile_image", userName: "John Doe")
    }
}
