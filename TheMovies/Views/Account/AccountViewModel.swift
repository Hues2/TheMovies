//
//  AccountViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import Foundation
import Combine


class AccountViewModel : ObservableObject {
    
    @Published var isloggedIn : Bool = false
    
    let authInteractor : AuthInteractor
    let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
        addSubscibers()
    }
    
    func signOut() {
        self.authInteractor.signOut()
    }
    
    func signIn() {
        self.appInteractor.showSignIn = true
    }
    
}


extension AccountViewModel {
    
    private func addSubscibers() {
        self.authInteractor.$user
            .sink { [weak self] returnedUser in
                guard let self else { return }
                guard let _ = returnedUser else {
                    self.isloggedIn = false
                    return
                }
                self.isloggedIn = true
            }
            .store(in: &cancellables)
    }
    
}
