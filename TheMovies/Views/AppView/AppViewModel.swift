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
    let apiInteractor : APIDataInteractor
    let favouritesInteractor : FavouritesInteractor
    let authInteractor : AuthInteractor
    let appInteractor : AppInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    // Init
    init(_ apiInteractor : APIDataInteractor,_ favouritesInteractor : FavouritesInteractor,
         _ authInteractor : AuthInteractor, _ appInteractor : AppInteractor) {
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
            .dropFirst()
            .sink { [weak self] returnedUser in
                print("APP VIEW MODEL RECEIVED CHANGE FROM USER")
                guard let self, let returnedUser else {
                    // User is nil --> So the user has logged out
                    self?.favouritesInteractor.logOut()
                    return
                }
                // A user has logged in
                // Fetch all the favourites belonging to this user
                self.favouritesInteractor.fetchFavourites(returnedUser.uid)
            }
            .store(in: &cancellables)
            
    }
    
}
