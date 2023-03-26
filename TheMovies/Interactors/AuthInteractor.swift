//
//  AuthInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation
import FirebaseAuth

class AuthInteractor : ObservableObject {
    
    @Published var user : User? = nil
    
    func registerNewUser(_ email : String, _ password : String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authDataResult, error) in
            guard let self else { return }
            guard let authDataResult else {
                // Registration unsuccessful
                self.user = nil
                return
            }
            // Registration successful
            self.user = authDataResult.user
        }
    }
    
    func signIn(_ email : String, _ password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authDataResult, error) in
            guard let self else { return }
            guard let authDataResult else {
                // Registration unsuccessful
                self.user = nil
                return
            }
            // Registration successful
            self.user = authDataResult.user
        }
    }
}
