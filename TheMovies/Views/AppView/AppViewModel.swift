//
//  AppViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 26/03/2023.
//

import Foundation
import Combine


class AppViewModel : ObservableObject {
    
    
    // Interactor Dependencies
    let homeNavigationInteractor : HomeNavigationInteractor
    let apiInteractor : APIDataInteractor
    let favouritesInteractor : FavouritesInteractor
    let authInteractor : AuthInteractor
    let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    // Init
    init(_ homeNavigationInteractor : HomeNavigationInteractor, _ apiInteractor : APIDataInteractor,
         _ favouritesInteractor : FavouritesInteractor, _ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
        self.homeNavigationInteractor = homeNavigationInteractor
        self.apiInteractor = apiInteractor
        self.favouritesInteractor = favouritesInteractor
        self.authInteractor = authInteractor
        self.appInteractor = appInteractor
        
        // Add the Combine subscribers
        addSubscribers()
    }
    
    
    
}


extension AppViewModel {
    
    private func addSubscribers() {
        self.authInteractor.$user
            
    }
    
}
