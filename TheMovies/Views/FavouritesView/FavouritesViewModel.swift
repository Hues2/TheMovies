//
//  FavouritesViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import Foundation
import Combine

class FavouritesViewModel : ObservableObject {
    
    
    
    let favouritesNavigationInteractor : FavouritesNavigationInteractor
    let apiInteractor : APIDataInteractor
    let favouritesInteractor : FavouritesInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    // Init
    init(_ favouritesNavigationInteractor : FavouritesNavigationInteractor, _ apiInteractor : APIDataInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self.favouritesNavigationInteractor = favouritesNavigationInteractor
        self.apiInteractor = apiInteractor
        self.favouritesInteractor = favouritesInteractor
        
        // Add the Combine subscribers

    }
    
    
}
