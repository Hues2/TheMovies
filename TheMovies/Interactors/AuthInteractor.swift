//
//  AuthInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 25/03/2023.
//

import Foundation


class AuthInteractor : ObservableObject {
    
    @Published var isSignedIn : Bool = false
    
    init() {
        
    }
}
