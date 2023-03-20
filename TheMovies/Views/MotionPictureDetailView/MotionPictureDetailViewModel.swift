//
//  MotionPictureDetailViewModel.swift
//  TheMovies
//
//  Created by Greg Ross on 15/03/2023.
//

import Foundation
import Combine


class MotionPictureDetailViewModel : ObservableObject {
    
    let motionPicture : MotionPictureData.MotionPicture
    @Published var favouritesChanged : Bool = false
    
    
    // Interactor Dependencies
    let favouritesInteractor : FavouritesInteractor
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ motionPicture : MotionPictureData.MotionPicture, _ favouritesInteractor : FavouritesInteractor) {
        self.motionPicture = motionPicture
        self.favouritesInteractor = favouritesInteractor
        
        addSubscribers()
    }
    
    // Add motion Picture To Favourites
    func alterFavourites() {
        favouritesInteractor.alterFavourites(motionPicture.id)
    }
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite() -> Bool {
        favouritesInteractor.isFavourite(motionPicture)
    }
    
}

// MARK: Subscribers
extension MotionPictureDetailViewModel {
    
    private func addSubscribers() {
        addFavouritesSubscribers()
    }
    
    
    private func addFavouritesSubscribers() {
        self.favouritesInteractor.$favouritesToggle
            .sink { [weak self] _ in
                guard let self else { return }
                self.favouritesChanged.toggle()
            }
            .store(in: &cancellables)
    }
}
