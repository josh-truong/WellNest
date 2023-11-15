//
//  ProfileView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/8/23.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @Binding var editMode: Bool
    
    var body: some View {
        HStack {
            Text(user.initials)
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
            
            Button {
                editMode = !editMode
            } label: {
                Image(systemName: "square.and.pencil")
            }
        }
    }
}

//#Preview {
//    ProfileView()
//}
