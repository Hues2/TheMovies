//
//  SignInViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import SwiftUI
import Combine

class SignInViewModel : ObservableObject {
    
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var isLoading : Bool = false
    @Published var errorMessage : String? = nil
    
    // Interactor Dependencies
    private let authInteractor : AuthInteractor
    private let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
        
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
        addSubscribers()
    }
    
}

// MARK: Subscribers
extension SignInViewModel {
    
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

// MARK: Sign In
extension SignInViewModel {
    
    func signIn() {
        guard readyToSignIn() else { return }
        self.isLoading = true
        authInteractor.signIn(self.email, self.password)
    }
    
    func readyToSignIn() -> Bool {
        return !self.email.isEmpty && !self.password.isEmpty
    }
    
}
