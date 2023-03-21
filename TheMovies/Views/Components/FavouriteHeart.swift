//
//  FavouriteHeart.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI

struct FavouriteHeart: View {
    
    let motionPicture : MotionPictureData.MotionPicture
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    let font : Font
    let isInToolBar : Bool
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(isInToolBar ? 0 : 0.4)
                .cornerRadius(10, corners: [.topRight, .bottomLeft])

            if favouritesInteractor.isFavourite(motionPicture) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(font)
                    .scaledToFit()
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            } else {
                Image(systemName: "heart")
                    .foregroundColor(.red)
                    .font(font)
                    .scaledToFit()
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
        }
    }
}
