//
//  FavouritesView.swift
//  TheMovies
//
//  Created by Greg Ross on 24/03/2023.
//

import SwiftUI
import URLImage

struct FavouritesView: View {
    
    @StateObject private var favouritesVM : FavouritesViewModel
    @Namespace private var namespace
    
    init(_ favouritesNavigationInteractor : FavouritesNavigationInteractor, _ apiDataInteractor : APIDataInteractor, _ favouritesInteractor : FavouritesInteractor) {
        self._favouritesVM = StateObject(wrappedValue: FavouritesViewModel(favouritesNavigationInteractor, apiDataInteractor, favouritesInteractor))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.backgroundColor
                .ignoresSafeArea()
            
            List {
                ForEach(favouritesVM.favouriteMotionPictures) { motionPicture in
                    favouriteCell(motionPicture)
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.backgroundColor)
                        .frame(height: 150)
                        .background(Color.backgroundColor.cornerRadius(10, corners: .allCorners).shadow(radius: 3))
                        .background(NavigationLink(value: AppPath.detail(motionPicture), label: {
                            Color.clear
                        }))
                }
                .onDelete { indexSet in
                    favouritesVM.removeFavourite(indexSet)
                }
            }
            .listStyle(.plain)
            .background(Color.backgroundColor)
            .padding(.top, 60)
            
            PillHeader(leftTitle: "List", rightTitle: "Grid", selectedType: nil, selectedViewType: favouritesVM.selectedViewType) {
                favouritesVM.selectedViewType = .list // Swipe Left
            } rightAction: {
                favouritesVM.selectedViewType = .grid // Swipe Right
            }
            
        }
    }
}


extension FavouritesView {
    
    private func favouriteCell(_ motionPicture : MotionPictureData.MotionPicture) -> some View {
        HStack(spacing: 20) {
            if let imageURL = motionPicture.posterURL {
                URLImage(imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                }
                .frame(width: 100, height: 130)
                .cornerRadius(10, corners: .allCorners)
                .clipped()
            }
    
            VStack(alignment: .leading, spacing: 15) {
                Text("\(motionPicture.title ?? motionPicture.name ?? "Unknown")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    
                Spacer()
                
                VStack {
                    HStack {
                        Text("\(motionPicture.release_date ?? motionPicture.first_air_date ?? "")")
                            .fontWeight(.thin)
                        Spacer()
                        RatingView(rating: motionPicture.vote_average ?? 0, frameSize: 30)
                            .frame(width: 35, height: 35)
                    }
                    
                }

            }
            .frame(height: 130)
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
