//
//  AuthInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation
import FirebaseAuth

class AuthInteractor : ObservableObject {
    
    @Published var isSignedIn : Bool = false
    
    private var appInteractor : AppInteractor?
    

    
    func update(_ appInteractor : AppInteractor) {
        self.appInteractor = appInteractor
    }
    
    func registerNewUser() {
        
    }
    
    func signIn() {
        guard let appInteractor else { return }
        appInteractor.showSignIn = false
    }
}
