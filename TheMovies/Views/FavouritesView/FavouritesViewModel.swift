//
//  FavouritesViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import Foundation
import Combine

class FavouritesViewModel : ObservableObject {
    
    @Published var favouriteMotionPictures = [MotionPictureData.MotionPicture]()
    
    // Sets the view to display either a grid or a list of favourites
    @Published var selectedViewType : ViewType = .grid
    
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
        addSubscribers()
    }
    
    enum ViewType {
        case grid, list
    }
}

extension FavouritesViewModel {
    
    private func addSubscribers() {
        addFavouritesSubscribers()
    }
    
}

// MARK: Favourites subscribers
extension FavouritesViewModel {
    
    private func addFavouritesSubscribers() {
        favouritesInteractor.$favouriteMotionPictures
            .sink { [weak self] returnedMotionPictures in
                self?.favouriteMotionPictures = returnedMotionPictures
            }
            .store(in: &cancellables)
    }
    
}
