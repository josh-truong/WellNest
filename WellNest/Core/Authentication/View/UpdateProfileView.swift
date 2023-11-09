//
//  UpdateEmailView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/4/23.
//

import SwiftUI

struct UpdateProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var name = ""
    @State private var email = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 32)
                
                Text("Update Profile")
                    .font(.system(size:35))
                    .multilineTextAlignment(.center)
                
                
                VStack(spacing: 24) {
                    InputView(text: $name,
                              title: "Name",
                              placeholder: viewModel.currentUser?.fullname ?? "")
                    .autocapitalization(.none)
                    
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: viewModel.currentUser?.email ?? "")
                    .autocapitalization(.none)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Cencel")
                            .background(Color(.systemRed))
                            .cornerRadius(10)
                            .padding(.top, 24)
                    }
                    
                    Button {
                        Task {
                            viewModel.signOut()
                            await viewModel.updateEmail(email: email)
                        }
                    } label: {
                        HStack {
                            Text("UPDATE PROFILE")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                    }
                    .background(Color(.systemBlue))
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
                    .cornerRadius(10)
                    .padding(.top, 24)
                }
            }
        }
    }
}

extension UpdateProfileView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return name != viewModel.currentUser?.fullname
        && email != viewModel.currentUser?.email
        && email.contains("@")
    }
}

#Preview {
    UpdateProfileView()
}
