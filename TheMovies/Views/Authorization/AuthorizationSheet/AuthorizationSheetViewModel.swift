//
//  AuthorizationSheetViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import Foundation
import Combine

class AuthorizationSheetViewModel : ObservableObject {
    
    @Published var isLoading : Bool = false
    
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
extension AuthorizationSheetViewModel {
    
    private func addSubscribers() {
        // When the user register an account successfully, the auth interactor will publish the User object returned from the registration
        self.authInteractor.$user
            .dropFirst()
            .sink { [weak self] returnedUser in
                guard let self else { return }
                guard let _ = returnedUser else {
                    // If the registration fails, we still have to remove the progressview
                    print("UNSSUCESSFUL")
                    self.isLoading = false
                    return
                }
                self.isLoading = false
                self.appInteractor.showSignIn = false // Dismiss Sign In/Register Sheet
            }
            .store(in: &cancellables)
    }
    
}
