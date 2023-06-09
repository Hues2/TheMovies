//
//  MiniMotionPictureCard.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI
import URLImage

struct MiniMotionPictureCard: View {
    
    let motionPicture : MotionPictureData.MotionPicture
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    @ObservedObject var authInteractor : AuthInteractor
    @ObservedObject var appInteractor : AppInteractor
    var gridCardSize : CGSize? = nil
    
    var body: some View {
        if let url = motionPicture.posterURL {
            URLImage(url) {
                miniLoadingCard
            } inProgress: { progress in
                miniLoadingCard
            } failure: { error, retry in
                miniLoadingCard
            } content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: gridCardSize?.width ?? 130, height: gridCardSize?.height ?? 200)
                    .overlay(alignment: .topTrailing) {
                        FavouriteHeart(motionPicture: motionPicture, favouritesInteractor: favouritesInteractor, font: .headline, isInToolBar: false)
                        .frame(width: 25, height: 25)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                                guard authInteractor.user != nil else {
                                    // Show Sign In
                                    appInteractor.showSignIn = true
                                    return
                                }
                                // Add the motion picture id to the favourites list in database
                                favouritesInteractor.alterFavourites(motionPicture)
                            }
                            HapticFeedback.shared.impact(.medium)
                        }
                    }
                    .clipped()
            }
    
        }
    }
}


extension MiniMotionPictureCard {
    private var miniLoadingCard : some View {
        ZStack {
            Color.backgroundColor
            ProgressView()
                .tint(Color.accentColor)
        }
        .frame(width: 130, height: 200)
    }
}
