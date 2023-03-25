//
//  FavouritesNavigationInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import Foundation

class FavouritesNavigationInteractor : ObservableObject {
    @Published var favouritesPath = [AppPath]()
    @Published var showSignIn : Bool = false
}
