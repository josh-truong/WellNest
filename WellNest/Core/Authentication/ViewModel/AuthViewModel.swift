//
//  AuthViewModel.swift
//  WellNest
//
//  Created by Joshua Truong on 11/2/23.
//

import Foundation
import Firebase

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel : ObservableObject {
    private var manager: AuthenticationService = AuthenticationService.shared
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async {
        do {
            self.userSession = try await manager.signIn(withEmail: email, password: password)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, fullname: String, password: String) async {
        do {
            let result = try await manager.createUser(withEmail: email, password: password)
            self.userSession = result
            let user = User(id: result.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try manager.signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        
        do {
            let user = try manager.getAuthenticatedUser()
            try await manager.deleteAccount(user: user)
            
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
    
    func updateEmail(email: String) async {
        do {
            let user = try manager.getAuthenticatedUser()
            manager.updateEmail(user: user, to: email)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update email with error \(error.localizedDescription)")
        }
    }
    
    func updatePassword(password: String) async {
        do {
            let user = try manager.getAuthenticatedUser()
            try await manager.updatePassword(user: user, to: password)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update password with error \(error.localizedDescription)")
        }
    }
}
