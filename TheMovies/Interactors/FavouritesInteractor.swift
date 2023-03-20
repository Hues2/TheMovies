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
    
    @Published var favouriteIDs = [Int]()
    @Published var favouritesToggle : Bool = false
    
    init() {
        fetchFavourites()
    }
    
    
    
    // I need to fetch the list of favourite ids from firebase and populate the favouriteIDs list
    private func fetchFavourites() {
        
    }
    
    func alterFavourites(_ id : Int?) {
        guard let id else { return } // Motion Picture could not be added to the favourites list, as the id is nil
        let indexOfId = self.favouriteIDs.firstIndex(of: id)
        guard let indexOfId else {
            // Add to favourite
            self.favouriteIDs.append(id)
            self.favouritesToggle.toggle()
            return
        }
        
        // Remove favourite
        self.favouriteIDs.remove(at: indexOfId)
        self.favouritesToggle.toggle()
    }
    
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite(_ motionPicture : MotionPictureData.MotionPicture) -> Bool {
        guard let id = motionPicture.id else { return false }
        let index = favouriteIDs.firstIndex(of: id)
        return index == nil ? false : true
    }
}
