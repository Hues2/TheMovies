//
//  FavouritesInteractor.swift
//  TheMovies
//
//  Created by Greg Ross on 19/03/2023.
//

import Foundation
import SwiftUI

/*
 This class handles the addidng and removing of favourites
 */

class FavouritesInteractor : ObservableObject {
    
    // This is the list that the favourites view uses to display
    @Published var favouriteMotionPictures = [MotionPictureData.MotionPicture]()
    
    // This is the list that the "favouirites heart" uses to check if the motion picture is already added as a favourite
    @Published var listOfFavouriteIDs = [Int]()
    @Published var favouritesToggle : Bool = false


    
    // I need to fetch the list of favourite ids from firebase
    // It will retreive a list of IDs
    // Then API calls will have to be made to retreive each corresponding motion picture
    func fetchFavourites(_ userID : String) {
        
    }
    
    func logOut() {
        self.favouriteMotionPictures = []
        self.listOfFavouriteIDs = []
        self.favouritesToggle.toggle()
    }
    
    func alterFavourites(_ motionPicture : MotionPictureData.MotionPicture) {
        
        guard let id = motionPicture.id else { return }
        let indexOfMotionPictureID = self.listOfFavouriteIDs.firstIndex(of: id)
        guard let indexOfMotionPictureID else {
            // Add to favourite]
            self.favouriteMotionPictures.append(motionPicture)
            self.listOfFavouriteIDs.append(id)
            self.favouritesToggle.toggle()
            return
        }
        
        // Remove favourite
        self.favouriteMotionPictures.remove(at: indexOfMotionPictureID)
        self.listOfFavouriteIDs.remove(at: indexOfMotionPictureID)
        self.favouritesToggle.toggle()
    }
    
    
    // Return true if the motion picture is in the list of favourites
    func isFavourite(_ motionPicture : MotionPictureData.MotionPicture) -> Bool {
        guard let id = motionPicture.id else { return false }
        return listOfFavouriteIDs.contains(id)
    }
    
    func removeFavourite(_ indexSet : IndexSet) {
        withAnimation {
            self.favouriteMotionPictures.remove(atOffsets: indexSet)
            self.listOfFavouriteIDs.remove(atOffsets: indexSet)
            self.favouritesToggle.toggle()
        }
    }
}
