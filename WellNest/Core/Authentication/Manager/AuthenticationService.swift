//
//  AuthenticationManager.swift
//  WellNest
//
//  Created by Joshua Truong on 11/8/23.
//

import Foundation
import FirebaseAuth

final class AuthenticationService {
    static let shared = AuthenticationService()
    private init() {}
    
    func getAuthenticatedUser() throws -> FirebaseAuth.User {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return user
    }
    
    @discardableResult
    func createUser(withEmail email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user
    }
    
    @discardableResult
    func signIn(withEmail email: String, password: String) async throws -> FirebaseAuth.User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func reauthenticateUser(user: FirebaseAuth.User, credentials: FirebaseAuth.AuthCredential) async throws -> FirebaseAuth.User {
        let result = try await user.reauthenticate(with: credentials)
        return result.user
    }

    func deleteAccount(user: FirebaseAuth.User) async throws {
        try await user.delete()
    }
}
