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

// MARK: Favourites Functionality
extension FavouritesViewModel {
    func removeFavourite(_ indexSet : IndexSet) {
        self.favouritesInteractor.removeFavourite(indexSet)
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
                guard let self else { return }
                self.favouriteMotionPictures = returnedMotionPictures
            }
            .store(in: &cancellables)
    }
    
}
