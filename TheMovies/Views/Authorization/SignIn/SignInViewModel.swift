//
//  SignInViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation


class SignInViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    
    private let authInteractor : AuthInteractor
    
    init(_ authInteractor : AuthInteractor) {
        self.authInteractor = authInteractor
    }
    
    
    func signIn() {
        guard readyToSignIn() else { return }
        authInteractor.signIn()
    }
    
}


extension SignInViewModel {
    
    func readyToSignIn() -> Bool {
        return !self.email.isEmpty && !self.password.isEmpty
    }
    
}
