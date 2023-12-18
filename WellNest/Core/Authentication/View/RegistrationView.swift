//
//  RegistrationView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/2/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .padding(.vertical, 32)
                
                Text("Welcome to\nWellNest!")
                    .font(.system(size:40))
                    .multilineTextAlignment(.center)
                
                
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        if email.isEmpty || !email.contains("@") {
                            Text("Invalid email")
                                .font(.caption2)
                                .foregroundStyle(.red)
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            InputView(text: $firstname,
                                      title: "First Name",
                                      placeholder: "Enter here")
                            if firstname.isEmpty {
                                Text("Missing first name")
                                    .font(.caption2)
                                    .foregroundStyle(.red)
                            }
                        }
                        VStack(alignment: .leading) {
                            InputView(text: $lastname,
                                      title: "Last Name",
                                      placeholder: "Enter here")
                            if lastname.isEmpty {
                                Text("Missing last name")
                                    .font(.caption2)
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                
                    
                    VStack(alignment: .leading) {
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                        if password.isEmpty {
                            Text("Password is missing")
                                .font(.caption2)
                                .foregroundStyle(.red)
                        } else if password.count < 5 {
                            Text("Password must be greater than 5 characters")
                                .font(.caption2)
                                .foregroundStyle(.red)
                        }
                    }
                    
                    ZStack(alignment: .trailing) {
                        InputView(text: $confirmPassword,
                                  title: "Confirm Password",
                                  placeholder: "Confirm your password",
                                  isSecureField: true)
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
                        await viewModel.createUser(withEmail: email,
                                                       fullname: "\(firstname) \(lastname)",
                                                       password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN UP")
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


extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !firstname.isEmpty
        && !lastname.isEmpty
        && !password.isEmpty
        && password.count > 5
        && password == confirmPassword
    }
}

#Preview {
    RegistrationView()
}
