//
//  FavouritesInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 19/03/2023.
//

import Foundation


/*
 This class handles the addidng and removing of favourites
 */

class FavouritesInteractor : ObservableObject {
    
    @Published var favouriteMotionPictures = [MotionPictureData.MotionPicture]()
    @Published var favouritesToggle : Bool = false
    
    init() {
        fetchFavourites()
    }
    
    
    
    // I need to fetch the list of favourite ids from firebase and populate the favouriteIDs list
    private func fetchFavourites() {
        
    }
    
    func alterFavourites(_ motionPicture : MotionPictureData.MotionPicture) {
        let indexOfMotionPicture = self.favouriteMotionPictures.firstIndex(of: motionPicture)
        guard let indexOfMotionPicture else {
            // Add to favourite
            self.favouriteMotionPictures.append(motionPicture)
            self.favouritesToggle.toggle()
            return
        }
        
        // Remove favourite
        self.favouriteMotionPictures.remove(at: indexOfMotionPicture)
        self.favouritesToggle.toggle()
    }
    
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite(_ motionPicture : MotionPictureData.MotionPicture) -> Bool {
        return favouriteMotionPictures.contains(motionPicture)
    }
}
