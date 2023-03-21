//
//  HorizontalScrollView.swift
//  TheMovies
//
//  Created by Greg Ross on 21/03/2023.
//

import SwiftUI

struct HorizontalScrollView: View {
    
    let motionPictures : [MotionPictureData.MotionPicture]
    @ObservedObject var favouritesInteractor : FavouritesInteractor
    let title : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text("\(title)")
                .font(.title2)
                .fontWeight(.semibold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(motionPictures) { motionPicture in
                        NavigationLink(value: HomeNavigationInteractor.HomePath.detail(motionPicture)) {
                            MiniMotionPictureCard(motionPicture: motionPicture, favouritesInteractor: favouritesInteractor)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                                .frame(width: 135, height: 210)
                        }
                    }
                }
            }
        }
    }
}
