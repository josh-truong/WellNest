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
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    
    func createUser(withEmail email: String, fullname: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            } else {
                self.userSession = nil
                self.currentUser = nil
            }
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
    
    func updateEmail(email: String) async throws {
        do {
            try await Auth.auth().currentUser?.updateEmail(to: email)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update email with error \(error.localizedDescription)")
        }
    }
    
    func updatePassword(password: String) async throws {
        do {
            try await Auth.auth().currentUser?.updatePassword(to: password)
            await fetchUser()
        } catch {
            print("DEBUG: Failed to update password with error \(error.localizedDescription)")
        }
    }
}
