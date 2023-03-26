//
//  RegisterViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation
import FirebaseAuth
import SwiftUI
import Combine


final class RegisterViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var confirmedPassword : String = ""
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
        
    private let authInteractor : AuthInteractor
    private let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
        
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
    }
    
}


// MARK: Subscribers
extension RegisterViewModel {
    
    private func addSubscribers() {
        self.authInteractor.$user
            .sink { [weak self] _ in
                guard let self else { return }
                self.isLoading = false
                self.errorMessage = nil
            }
            .store(in: &cancellables)
        
        self.authInteractor.errorPublisher
            .sink { [weak self] returnedError in
                guard let self else { return }
                self.isLoading = false
                self.errorMessage = returnedError.localizedDescription
            }
            .store(in: &cancellables)
    }
    
}

// MARK: Register
extension RegisterViewModel {
    
    func register() {
        guard readyToRegister() else { return }
        self.isLoading = true
        authInteractor.registerNewUser(self.email, self.password)
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
