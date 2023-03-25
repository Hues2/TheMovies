//
//  RegisterViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation
import FirebaseAuth


final class RegisterViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var confirmedPassword : String = ""
    
    private let authInteractor : AuthInteractor
    
    init(_ authInteractor : AuthInteractor) {
        self.authInteractor = authInteractor
    }
    
}


// MARK: Register
extension RegisterViewModel {
    
    func register() {
        guard readyToRegister() else { return }
        
    }
    
}

// MARK: Validation
extension RegisterViewModel {
    
    func emailHasRedBorder() -> Bool {
        return (self.email.isValidEmail || self.email.isEmpty)
    }
    
    func passwordHasRedBorder() -> Bool {
        // Password Validation
        return self.password.isValidPassword || self.password.isEmpty
    }
    
    func confirmedPasswordHasRedBorder() -> Bool {
        return ((self.password == self.confirmedPassword))
    }
    
    func readyToRegister() -> Bool {
        return self.email.isValidEmail && self.password.isValidPassword && self.confirmedPassword == self.password
    }
    
}
