//
//  UpdatePasswordView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/4/23.
//

import SwiftUI

struct UpdatePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 32)
                
                Text("Update Email Account")
                    .font(.system(size:35))
                    .multilineTextAlignment(.center)
                
                
                VStack(spacing: 24) {
                    InputView(text: $password,
                              title: "Update Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    .autocapitalization(.none)
                    
                    
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
                                  isSecureField: true)
                        .autocapitalization(.none)
                        
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemGreen))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemRed))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                Button {
                    Task {
                        try await viewModel.updatePassword(password: password)
                    }
                } label: {
                    HStack {
                        Text("UPDATE EMAIL")
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Sign in")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

extension UpdatePasswordView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !password.isEmpty
        && password.count > 5
        && !confirmPassword.isEmpty
        && confirmPassword.count > 5
    }
}

#Preview {
    UpdatePasswordView()
}
