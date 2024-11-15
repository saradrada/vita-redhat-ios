//
//  AuthViewModel.swift
//  Vita
//

import FirebaseAuth
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?

    init() {
        self.isAuthenticated = Auth.auth().currentUser != nil
    }

    var userEmail: String? {
           return Auth.auth().currentUser?.email
       }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = nil
                self?.isAuthenticated = true
            }
        }
    }

    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                print("Registration Error: \(error.localizedDescription) - \(error)")
            } else {
                self?.errorMessage = nil // Clear error message on success
                self?.isAuthenticated = true
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
