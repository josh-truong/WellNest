//
//  UpdateEmailView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/4/23.
//

import SwiftUI

struct UpdateEmailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var confirmEmail = ""
    
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
                    InputView(text: $email,
                              title: "Update Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmEmail,
                                  title: "Confirm Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        if !email.isEmpty && !confirmEmail.isEmpty {
                            if email == confirmEmail {
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
                        try await viewModel.updateEmail(email: email)
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

extension UpdateEmailView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && !confirmEmail.isEmpty
        && email.contains("@")
        && confirmEmail.contains("@")
    }
}

#Preview {
    UpdateEmailView()
}
