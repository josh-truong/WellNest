//
//  ProfileView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/2/23.
//

import SwiftUI

struct ProfileSettingView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var profileEditMode: Bool = false
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    ProfileView(user: user, editMode: $profileEditMode)
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        Task {
                            viewModel.signOut()
                        }
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                    }
                    
                    Button {
                        Task {
                            await viewModel.deleteAccount()
                        }
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileSettingView()
        .environmentObject(AuthViewModel())
}
