//
//  ProfileView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    
    var body: some View {
        HStack {
            Text(user.fullname.initals)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 72, height: 72)
                .background(Color.gray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.top, 4)
                Text(user.email)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
        }
    }
}
